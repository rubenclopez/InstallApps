require 'pty'
begin
  PTY.spawn( "ls --help" ) do |stdin, stdout, pid|
    begin
      stdin.each { |line| print line }
      puts "STDERR: #{$?}"
      puts 
    rescue Errno::EIO
    end
  end
rescue PTY::ChildExited 
  puts "The child process exited!"
 	puts "STATUS: #{Process::Status}"
end