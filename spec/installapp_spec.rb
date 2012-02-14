require "spec_helper.rb"
require "exec_application.rb"

describe "Running an application and getting it's output and exit code" do
	describe "#init" do
		before(:each) do 
			@g = ExecApplication::init("ruby -v")
		end

		it "should be successfull" do
			@g[1].should eql(0)
		end

		it "should be uncessfull" do
			output = ExecApplication::init("ruby --badcommand")
			output[1].should be > 1
		end
	
		it "it should return no output" do
			@g[0].should_not != nil
		end

		it "should test no arguments" do
			expect { ExecApplication::init() }.to raise_error(ArgumentError)
		end
	end
end