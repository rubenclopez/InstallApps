require "spec_helper.rb"
require "exec_application.rb"

describe ExecApplication do
	describe "#init" do
		before(:each) do 
			g = ExecApplication::init("ruby -v")
			puts "######## #{g}"
		end

		it "execulation is successfull." do
			true
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
end