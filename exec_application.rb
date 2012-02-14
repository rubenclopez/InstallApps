require 'rubygems'
require 'popen4'

module ExecApplication
  attr_accessor :response, :exitcode

  def self.init(cmd = false)
  		if cmd
  			output    = POpen4::popen4(cmd) { |out, err, stdin| @response = out.map { |l| l } }
      	@exitcode  = output.exitstatus    
      	@response = @response.join("")
      	[@response, @exitcode]	
  		else
  			puts "You must pass a cmd as a variable. exiting..."
  			false
    	end	
  end

end
