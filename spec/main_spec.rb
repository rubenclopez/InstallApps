
### TODO: Figure out what I need to do to get this to work with main app



require "spec_helper.rb"

describe InstallApplication, "Running an application and getting it's output and exit code" do
	
	describe "#check_requirements?"
		it "returns true or false depending on symbol passed"
		it "complains when its required argument is not passed"
		it "checks if xcode is installed"
		it "checks if the application folder is present"
		it "checks if the customizations folder is present"
		it "checks that the current OS is OSX Lion"
	end

	describe "#install_application"
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

	describe "#extract_files"
		it "extracts .tar files" do
			pending
		end
		it "extracts .zip files" do
			pending
		end
		it "extracts .tar.gz files" do
			pending
		end
		it "returns exitcode 0 (SUCCESS)" do
			pending
		end
	end

	describe "#install_brew_apps"
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

	describe "#application_installed?"
		it "returns true" do
			pending
		end
		it "returns false" do
			pending
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

	describe "#install_draggable_applications"
	it "complains when its requirement argument is not passed"
	it "returns exitcode 0"
	end

end # END OF parent describe block


