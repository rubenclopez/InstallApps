require "spec_helper.rb"
require "exec_application.rb"

describe ExecApplication do
	describe "#init" do
		before(:each) do 
			@g = ExecApplication::init("ruby -v")
		end

		it "executing was successful" do
			@g[1].should eql(0)
		end

		it "executing failed" do
			output = ExecApplication::init("ruby --badcommand")
			output[1].should be > 1
		end
	
		it "exection returned no output" do
			@g[0].should_not != nil
		end

		it "not paramaters passed" do
			expect { ExecApplication::init() }.to raise_error(ArgumentError)
		end
	end
end