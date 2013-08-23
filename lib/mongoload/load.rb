
require 'mysql2'

command :'load:mysql' do |c|
  c.syntax = 'load:mysql'
  c.summary = 'Load data from MySQL to MongoDB'
  c.action do |args, options|

	client = Mysql2::Client.new(
		:host => "localhost", 
		:username => "root", 
		:password => "p@ssword",
		:reconnect => true
	)

	client.query("SELECT * FROM fec.uniquepeople LIMIT 5").each do |row|
		say_ok row["name_first"]
	end
  end
end
