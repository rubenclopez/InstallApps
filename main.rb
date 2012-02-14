module Main

  def self.check_requirements?(app)
    
    # case app
    #   when :xcode
    #     xcode_version = ExecApplication::init("xcodebuild -version 2>&1 /dev/null")[0][/.*[^\n]/].split.last
    #     xcode_version[/4.*/] ? true : false
    #   when :AppFolder
    #     File.exists? "Applications"
    #   when :CustomizationFolder
    #     File.exists? "Customizations"
    #   when :OSVersion
    #     os_version    = ExecApplication::init("cat /System/Library/CoreServices/SystemVersion.plist | grep '10.7' | head -n1")[0][/\d{2}\.\d+\.\d+/]
    #     os_version[/7.*/] ? true : false
    # end

  end


  def self.install_application(app)
    case app
      when :xcode
             
        install_output = ExecApplication::init('sudo installer -verbose -pkg ./Applications/Install\\ Xcode.app/Contents/Resources/Xcode.mpkg -target /') 
      when :brew
        current_user = `whoami`.chomp
        ExecApplication::init('sudo mkdir -p /usr/local/Cellar') 
        ExecApplication::init('sudo chown -R "#{current_user}":staff /usr/local/Cellar')
              
        install_output = ExecApplication::init("/usr/bin/ruby -e $(curl -fsSL https://raw.github.com/gist/323731) & osascript ../../AppleScript/simulate_key.script") 
        ExecAppli
        puts "Installing Brew Apps: ack, wget, curl, redis, memcached, libmemcached, colordiff, imagemagick... "
        ExecApplication::init('brew install ack wget curl redis memcached libmemcached colordiff imagemagick') 
        emulate_keystroke(36)
      when :rvm
        File.open(".rvminstall", "w") { |f| f.puts "bash -s stable < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer)" }
        #`bash ./.rvminstall 2>&1`
        File.delete('.rvminstall')
        ExecApplication::init('~/.rvm/bin/rvm pkg install readline iconv')
      when :ruby
        #`rvm install 1.9.3`
      ## TODO: Add Sophos anti-virus
      ## TODO: Add LittleSnitch
    end
  end

  def self.extract_files(zip, extract_location)
    case zip
      when /.tar$/
        print "Extracting #{zip} into #{extract_location}... "
        extract_output = ExecApplication::init("mkdir -p ~/.ssh && tar -xf ./Personal/#{zip} -C ~/.ssh") 
      puts "[DONE]"
    end
  end


  def self.install_brew_apps(applications)
    applications.each do |app|
      puts "Brewing appliation #{app}... "
      brew_install_output = ExecApplication::init("brew install #{app}") 
       
       case app
         when "mysql"
           current_user = ExecApplication::init("whoami")[0] 
           brew_basedir = ExecApplication::init("brew --prefix mysql")[0]
           puts "Configuring mysql..."
           mysql_config_data = ExecApplication::init("/usr/local/bin/mysql_install_db --verbose --user=#{current_user} --basedir=#{brew_basedir} --datadir=/usr/local/var/mysql --tmpdir=/tmp") 
           puts "Starting MySQL..."
           mysql_start_data = ExecApplication::init("mysql.server start") 
           puts "   mysql_start_data"
       end
    end 
  end

  
  def self.application_installed?(app)
    File.exists?(app)
  end  


  def self.init_check_requirements
    print "Checking for Application folder... "
    if check_requirements?(:AppFolder)
      puts "[PASS]"
    else
      puts "#{PROGRAM_NAME}: application folder not found."
      exit 1
    end

    print "Checking for Customization folder... "
    if check_requirements?(:CustomizationFolder)
      puts "[PASS]"
    else
      puts "#{PROGRAM_NAME}: Customizations folder not found."
      exit 1
    end
  end

  def self.init_additional_applications(types)
    puts "Installing applications... " unless types.empty?
    apps =  [
              "Sublime Text 2 Build 2165.dmg", "Sequel_Pro_0.9.9.1.dmg", "Skype_5.3.59.1093.dmg",
              "Adium_1.4.4.dmg", "Firefox 9.0.1.dmg", "vlc-1.1.12-intel64.dmg", "Sparrow-latest.dmg",
              "CarbonCopy-3.4.4.dmg", "Dropbox 1.2.51.dmg", "Office_2008.mpkg", "VirtualBox.mpkg", 
              "Adobe Flash Player.pkg", "GrowlNotify.pkg", "iPhoto.pkg", "iPhotoContent.pkg", 
              "iPhotoLibraryUpgradeTool.pkg", "The Unarchiver.app", "Divvy.app", "MemoryFreer.app", 
              "Loginox 1.0.5b3.app", "NoobProof.app", "WaterRoof.app", "smcFanControl.app", 
              "LockScreen2.app", "Flare.app", "All2MP3.app", "Anemona.saver", "Flux.saver", 
              "Helios.saver", "Hyperspace.saver", "Red Pill.saver", "Twistori - Snow Leopard.saver",
              "Inconsolata.otf", "monof55.ttf", "monof56.ttf"  
            ]
    install_draggable_applications(apps)  
  end



  ### TODO: Certain applications will be better placled in the /Applications/Utilities folder 
  def self.install_by_copy(app)
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
      when ".mpkg", ".pkg"
        input_path  = "./Applications"
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

  def self.install_draggable_applications(app)
      case app
        when app[/.app/]
          print "  Mounting application #{app}... "  
              mount_point = `hdiutil mount Applications/"#{app}" | tail -n1`.split[2..-1].join(" ")

        when app[/\.mpkg|\.pkg/]
        when app[/.saver/]
        when app[/\.otf|\.ttf/]
        when app[/\.zip|\.tar\.gz|\.tar/]
      end
         
    #   puts "[DONE]"
    #   print "  Copying #{app} to Applications folder... "
    #   app_dir  = Dir.glob("#{mount_point}/*.app").first
    #   app_name = app_dir.split("/").last
    #   if application_installed?("/Applications/#{app_name}") 
    #     puts
    #     puts "    #{app_name} is already installed... [Abording]"
    #   else
    #     FileUtils.cp_r app_dir, "/Applications"
    #     puts "[DONE]"
    #     case app_name
    #       when "Sublime Text 2"
    #         puts "  Configuring Sublime... "
    #         shortcut_create = ["#!/bin/sh", "/Applications/\"Sublime\ Text\ 2.app\"/Contents/SharedSupport/bin/subl $1 $2 $3 $4"]
    #         File.open(".sublimeconfig", "w") { |f| f.puts shortcut_create }
    #         `sudo mkdir -p /usr/local/bin && mv .sublimeconfig /usr/local/bin/s && chmod 755 /usr/local/bin/s`
    #     end
           

    #   end
    #   print "       Unmounting disk image... "
    #   `hdiutil unmount "#{mount_point}"`
    #   puts "[DONE]"
    # end  
  end



end ### END FOR MODULE
