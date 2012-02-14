require "spec_helper.rb"
require "exec_application.rb"

describe ExecApplication, "Running an application and getting it's output and exit code" do
	describe "#init" do
		before(:each) do 
			@g = ExecApplication::init("ruby -v")
		end

		it "should be successfull" do
			@g[1].should == 0
		end

		it "should be uncessfull" do
			@g[1].should equal(0)
		end
	
		it "it should return no output" do
			output = ExecApplication::init("ls 2>&1 > /dev/null")[0]
			output.should == ""
		end

		it "should test no arguments" do
			expect { ExecApplication::init() }.to raise_error(ArgumentError)
		end
	end
end

