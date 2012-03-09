
### TODO: Figure out what I need to do to get this to work with main app



require "spec_helper.rb"
require 'main.rb'

describe Main do
  
  describe "#check_requirements?" do
    it "returns true or false depending on symbol passed"
    it "complains when its required argument is not passed"
    it "checks if xcode is installed"
    it "checks if the application folder is present"
    it "checks if the customizations folder is present"
    it "checks that the current OS is OSX Lion"
  end

  describe "#install_application" do
    it "installs brew" do
      pending
    end
    it "installs rvm" do
      pending
    end
    it "installs ruby" do
      pending
    end

    it "returns exitcode 0 (SUCCESS)" do
      pending
    end

  end

  describe "#extract_files" do



    after(:each) do 
      file = '/tmp/.test_file'
      File.delete(file) if File.exists?(file)
    end

    def contains_extracted_content?(file, content)
      if File.exists?(file)
        File.read(file).chomp == content ? true : false
      else
        false
      end
    end

    it "extracts .tar files" do
      Main::extract_files('spec/assets/test_file.tar', '/tmp')
      contains_extracted_content?('/tmp/.test_file', '.tar').should be true
    end
    it "extracts .zip files" do
      Main::extract_files('spec/assets/test_file.zip', '/tmp')
      contains_extracted_content?('/tmp/.test_file', '.zip').should be true
    end
    it "extracts .tar.gz files" do
      Main::extract_files('spec/assets/test_file.tar.gz', '/tmp')
      contains_extracted_content?('/tmp/.test_file', '.tar.gz').should be true
    end
    it "returns exitcode 1 (FAILED)" do
      output = Main::extract_files('spec/assets/file-not-found', '/tmp')
      output.should be false
    end
  end

  describe "#install_brew_apps" do
    it "complains when its required argument is not passed" do
      pending
    end
    it "accepts an array" do
      pending
    end
    it "does post installation for mysql" do
      pending
    end
    it "returns exitcode 0 (SUCCESS)" do
      pending
    end
  end

  describe "#application_installed?" do
    describe "returns true" do
      it "when given a relative path" do
        Main::application_installed?("VLC").should be true
      end
      it "when given an absolute path" do
        Main::application_installed?("/Applications/VLC.app").should be true
      end
    end

    describe "returns false" do
      it "when given a relative path" do
        Main::application_installed?("NOTFOUND").should be false
      end
      it "when given an absolute path" do
        Main::application_installed?("/Applications/NOTFOUND.app").should be false
      end
    end
  end

  describe "#init_check_requirements" do
    it "checks for the presence of Applications folder"
    it "check for the presence of Customization folder"
  end

  describe "#init_additional_applications" do
    it "complains when its required argument is not passed"
    it "returns exitcode 0 (SUCCESS)"
  end

  describe "#install_by_copy" do
    it "complains when its required argument is not passed"
    it "installs .app files"
    it "install screen savers"
    it "installs fonts"
    it "installs packages"
    it "returns exitcode 0 (SUCCESS)"
  end

  describe "#install_draggable_applications" do
    it "complains when its requirement argument is not passed"
    it "returns exitcode 0"
  end

end # END OF parent describe block


