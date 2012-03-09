require 'rubygems'
require 'popen4'

module ExecApplication
  attr_accessor :response, :exitcode

  def self.init(cmd = false)
  		if cmd
  			output    = POpen4::popen4(cmd) { |out, err, stdin| @response = out.map { |l| l } }
      	@exitcode  = output.exitstatus    
      	@response = @response.join("")
        @exitcode == 0 ? true : false
      	[@response, @exitcode]	
  		else
  			false
    	end	
  end

end
