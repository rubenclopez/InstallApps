#!/usr/bin/env ruby

def check_requirements?(app)

  case app
    when :xcode
      xcode_version = `xcodebuild -version 2>&1 /dev/null`[/.*[^\n]/].split.last
      xcode_version[/4.*/] ? true : false
    when :AppFolder
      Dir.exists? "Applications"
    when :CustomizationFolder
      Dir.exists? "Customizations"
    when :OSVersion
      os_version    = `cat /System/Library/CoreServices/SystemVersion.plist | grep '10.7' | head -n1`[/\d{2}\.\d+\.\d+/]
      os_version[/7.*/] ? true : false
  end

end

puts "This application installed the primary applications I use in my normal every day computer"
puts 

print "Checking for OSX Lion... "
puts check_requirements?(:OSVersion) ? "[FOUND]" : "[ERROR.. This system is not running OSX Lion]"

print "Checking for Xcode... "
puts check_requirements?(:xcode) ? "[FOUND]" : "[ERROR.. Not found]"


print "Checking for Application folder... "
puts check_requirements?(:AppFolder) ? "[FOUND]" : "[ERROR.. Not found]"

print "Checking for Customization folder... "
puts check_requirements?(:CustomizationFolder) ? "[FOUND]" : "[ERROR.. Not found]"




