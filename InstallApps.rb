#!/usr/bin/env ruby

require 'fileutils'

class String 
  def f_extension
    File.extname self
  end

  def f_name
    File.basename self
  end

  def f_base
    f_name.split(".").first
  end

  def f_abs_path
    ## This seems over-kill, and I missing something???
    path = File.expand_path(self).split("/")
    path.pop
    path.join("/")
  end
end

def check_requirements?(app)
  
  case app
    when :xcode
      xcode_version = `xcodebuild -version 2>&1 /dev/null`[/.*[^\n]/].split.last
      xcode_version[/4.*/] ? true : false
    when :AppFolder
      File.exists? "Applications"
    when :CustomizationFolder
      File.exists? "Customizations"
    when :OSVersion
      os_version    = `cat /System/Library/CoreServices/SystemVersion.plist | grep '10.7' | head -n1`[/\d{2}\.\d+\.\d+/]
      os_version[/7.*/] ? true : false
  end

end

def install_application(app)
  case app
    when :xcode
      puts `sudo installer -verbose -pkg ./Applications/Install\\ Xcode.app/Contents/Resources/Xcode.mpkg -target /`
    when :brew
      current_user = `whoami`.chomp
      `sudo mkdir -p /usr/local/Cellar`
      `sudo chown -R "#{current_user}":staff /usr/local/Cellar`
      puts "Please press enter twice to install" # Figure out a way to not need to do this
      puts `/usr/bin/ruby -e "$(curl -fsSL https://raw.github.com/gist/323731)"`
      puts "Installing Brew Apps: ack, wget, curl, redis, memcached, libmemcached, colordiff, imagemagick... "
      `brew install ack wget curl redis memcached libmemcached colordiff imagemagick`
    when :rvm
      File.open(".rvminstall", "w") { |f| f.puts "bash -s stable < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer)" }
      #`bash ./.rvminstall 2>&1`
      File.delete('.rvminstall')
      `~/.rvm/bin/rvm pkg install readline iconv`
    when :ruby
      #`rvm install 1.9.3`
  end

end

def extract_files(zip, extract_location)
  case zip
    when /.tar$/
	print "Extracting #{zip} into #{extract_location}... "
	`mkdir -p ~/.ssh && tar -xf ./Personal/"#{zip}" -C ~/.ssh`
	puts "[DONE]"
  end

end

def install_brew_apps(applications)
  applications.each do |app|
    puts "Brewing appliation #{app}... "
    `brew install "#{app}"`
     
     case app
       when "mysql"
         current_user = `whoami`
         brew_basedir = `brew --prefix mysql`
         puts "Configuring mysql..."
         puts `/usr/local/bin/mysql_install_db --verbose --user="#{current_user}" --basedir="#{brew_basedir}" --datadir=/usr/local/var/mysql --tmpdir=/tmp`
	       puts "Starting MySQL..."
	       puts `mysql.server start`
     end

  end 
end

def application_installed?(app)
  File.exists?(app)
end


### THIS needs to be fixed
def install_by_copy(app)


  case app.f_extension
    when ".app"
      input_path  = "./Applications"
      output_path = "/Applications"
    when ".saver"
      input_path  = './Customizations/Screen\\ Savers'
      output_path = '~/Library/Screen\\ Savers'
    when ".ttf", ".otf"
      input_path  = './Customizations/Fonts'
      output_path = '~/Library/Fonts'
  end  

  if application_installed?("#{output_path}/#{app}") && input_path && output_path
    puts "  #{app} is already installed... [Aborting]"
  else
    print "  Installing #{app.f_base}... "
    File.open(".appinstall", "w") { |f| f.puts "cp -r #{input_path}/\"#{app}\" #{output_path}" }
    system "bash ./.appinstall && rm .appinstall"
    puts "[DONE]"
  end
end

def install_draggable_applications(applications)
  applications.each do |app|
    print "  Mounting application #{app}... "  
    mount_point = `hdiutil mount Applications/"#{app}" | tail -n1`.split[2..-1].join(" ")
    puts "[DONE]"
    print "  Copying #{app} to Applications folder... "
    app_dir  = Dir.glob("#{mount_point}/*.app").first
    app_name = app_dir.split("/").last
    if application_installed?("/Applications/#{app_name}") 
      puts
      puts "    #{app_name} is already installed... [Abording]"
    else
      FileUtils.cp_r app_dir, "/Applications"
      puts "[DONE]"
      case app_name
        when "Sublime Text 2"
          puts "  Configuring Sublime... "
          shortcut_create = ["#!/bin/sh", "/Applications/\"Sublime\ Text\ 2.app\"/Contents/SharedSupport/bin/subl $1 $2 $3 $4"]
          File.open(".sublimeconfig", "w") { |f| f.puts shortcut_create }
          `sudo mkdir -p /usr/local/bin && mv .sublimeconfig /usr/local/bin/s && chmod 755 /usr/local/bin/s`
      end
         

    end
    print "  Unmounting disk image... "
    `hdiutil unmount "#{mount_point}"`
    puts "[DONE]"
  end  
end



puts "This application installed the primary applications I use in my normal every day computer"
puts 
print "Sudoing... "
`sudo ls`

print "Checking for OSX Lion... "
puts check_requirements?(:OSVersion) ? "[FOUND]" : "[ERROR.. This system is not running OSX Lion]"

print "Installing personal system files..."
extract_files("ssl_key.tar", "~/.ssh/")


print "Checking for Xcode... "
if check_requirements?(:xcode) 
  puts "[FOUND]"
else
  puts "[ERROR.. Not found]"
  puts "Installing Xcode 4.2.2... Notice: This will take a while"
  install_application(:xcode)
  puts "[DONE]"
end

puts "Installing brew... "
#install_application(:brew)

puts "Install brew applications... "
apps = %w|mysql|
#install_brew_apps(apps)
print "[DONE]"

puts "Installing RVM... "
#install_application(:rvm)
print "[DONE]"


print "Installing ruby 1.9.3"
install_application(:ruby)


print "Checking for Application folder... "
puts check_requirements?(:AppFolder) ? "[FOUND]" : "[ERROR.. Not found]"

puts "Installing applications... "
apps =  [
          "Sublime Text 2 Build 2165.dmg", "Sequel_Pro_0.9.9.1.dmg", "Skype_5.3.59.1093.dmg",
          "Adium_1.4.4.dmg", "Firefox 9.0.1.dmg"
        ]
install_draggable_applications(apps)
#apps = ["Divvy.app", "MemoryFreer.app"]
apps = []
apps.each { |app| install_by_copy(app) }

print "Checking for Customization folder... "
puts check_requirements?(:CustomizationFolder) ? "[FOUND]" : "[ERROR.. Not found]"

puts "Installing Screen Savers... "
screen_savers = [
                  "Anemona.saver", "Flux.saver", "Helios.saver", "Hyperspace.saver", "Red Pill.saver", 
                  "Twistori - Snow Leopard.saver"
                ]
screen_savers.each { |screen_saver| install_by_copy(screen_saver) }

puts "Installing Fonts..."
fonts = ["Inconsolata.otf", "monof55.ttf", "monof56.ttf"
        ]
fonts.each { |font| install_by_copy(font) }
