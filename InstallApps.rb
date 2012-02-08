#!/usr/bin/env ruby

require 'fileutils'

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



puts "This application installed the primary applications I use in my normal every day computer"
puts 

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

print "Installing brew... "
#install_application(:brew)

puts "Installing RVM... "
#install_application(:rvm)
print "[DONE]"


print "Installing ruby 1.9.3"
install_application(:ruby)


print "Checking for Application folder... "
puts check_requirements?(:AppFolder) ? "[FOUND]" : "[ERROR.. Not found]"

print "Checking for Customization folder... "
puts check_requirements?(:CustomizationFolder) ? "[FOUND]" : "[ERROR.. Not found]"
