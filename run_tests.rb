#!/usr/bin/env ruby


require 'spec_helper'

describe InstallApplications do

end

describe emulate_keyboard do
	pending
end




describe ExecApplication 

task :default => [:test]

Rake::TestTask.new do |test|
	test.libs << "test"
	test.test_files = Dir["test/test_*.rb"]
	test.verbose = true
end

