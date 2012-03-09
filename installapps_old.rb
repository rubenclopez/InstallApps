#!/usr/bin/env ruby

## TODO: Add a way to install .pkg files by themselves. 



require 'fileutils'
require 'rubygems'
require 'popen4'

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


def emulate_keystroke(key)
  #["tell application "System Events"]
end


 





  # puts "Please press enter twice to install" # Figure out a way to not need to do this
  #     puts `/usr/bin/ruby -e "$(curl -fsSL https://raw.github.com/gist/323731)"`
  #     puts "Installing Brew Apps: ack, wget, curl, redis, memcached, libmemcached, colordiff, imagemagick... "
  #     `brew install ack wget curl redis memcached libmemcached colordiff imagemagick`
  #   when :rvm








def install_packages(app)

         `installer -pkg "#{app}" -target /`

end


puts 

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



