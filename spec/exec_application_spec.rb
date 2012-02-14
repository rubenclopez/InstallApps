require "spec_helper.rb"
require "exec_application.rb"

describe ExecApplication, "Running an application and getting it's output and exit code" do
	
	describe "#init" do
		before(:each) do 
			@g = ExecApplication::init("ruby -v")
		end

		it "should return an array containing a output and exit status" do
			@g.class.should == Array
			@g.count.should == 2
		end
		
		it "should return an exit status of 0 (SUCESS)" do
			@g[1].should == 0
		end

		it "should return an exit status greater than 0 (ERROR)" do
			@g[1].should be <= 0
		end

		it "should complain when its required parameter was not given" do
			output = ExecApplication::init()
			output.should == false
		end
	end
end

