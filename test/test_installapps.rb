require 'spec_helper'


module InstallApplication

	describe "ExecApplication module" do
				before :all do
					output = ExecApplication::init("ruby -v")
				end

				it "execulation is successfull." do
					pending
				end

				it "exection exited with error code" do
					pending
				end
			
				it "exection returned no output" do
					pending
				end

				it "not paramaters passed" do
					pending
				end
	end


	describe "check #emulate" do
		it "no parameter passed" do
			pending
		end

		it "a parameter was passed to method" do
			pending
		end
	end

	describe "#install_application" do

		it "no parameter passed" do
			pending
		end

		it "a parameter was passed to method" do
			pending
		end
		
		it "application did not run properly" do
			pending
		end	

		it "application ran succesfully" do
			pending
		end


	end

	describe "#install_packages" do
		pending
	end
	
end