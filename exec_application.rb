require 'rubygems'
require 'popen4'

module ExecApplication
  attr_accessor :response, :exitcode

  def self.init(cmd)
  		puts "You must pass a cmd as a variable. exiting..." unless cmd
  		
      output    = POpen4::popen4(cmd) { |out, err, stdin| @response = out.map { |l| l } }
      @exitcode  = output.exitstatus    
      @response = @response.join("")
      [@response, @exitcode]
  end

end
