require "spec_helper.rb"
require "exec_application.rb"

describe ExecApplication do
	
	describe "#init" do
		def exec(arg = 'ruby -v')
			cmd = ExecApplication::init(arg)
			cmd
		end

		it "returns an array containing a output and exit status" do
			exec().class.should == Array
			exec().count.should == 2
		end
		
		it "returns an exit status of 0 (SUCESS)" do
			exec()[1].should == 0
		end

		it "returns an exit status greater than 0 (ERROR)" do
			exec('ruby --fail')[1].should be > 0
		end

		it "complains when its required parameter was not given" do
			exec(nil).should == false
		end
	end
end

