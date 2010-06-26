#!/usr/bin/env ruby

# (re)create the sqlite db by running all the sql scripts under db/

dir = File.expand_path(File.join(File.dirname(__FILE__), '..', 'db'))
db = File.join(dir, 'lifestream.db')
files = File.join(dir, '*.sql')

%x[ls -1 #{files}].each do |file|
	system "cat #{file.chomp} | sqlite3 #{db}"
end
