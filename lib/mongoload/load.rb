
require 'mysql2'
require 'mongo'

include Mongo

command :'load:mysql' do |c|
  c.syntax = 'load:mysql'
  c.summary = 'Load data from MySQL to MongoDB'
  c.option '--start STRING', String, 'Starts at index'
  c.action do |args, options|


	client = Mysql2::Client.new(
		:host => "localhost", 
		:username => "root", 
		:password => "p@ssword",
		:reconnect => true
	)

	initialQuery = "SELECT id,name,name_last,name_first,city,state,zip_code,employer,occupation,transaction_dt,transaction_amt,cmte_nm,cmte_pty_affilitation,cand_name,cand_pty_affilitation FROM fec.indiv_flattened" 

	if options.start
		initialQuery += " WHERE id >= " + options.start
	end

	initialQuery += " LIMIT 1000000"

	results = client.query(initialQuery)

	totalRows = results.count
	totalProcessed = 0
	total_time = 0

	host = ENV['MONGO_RUBY_DRIVER_HOST'] || 'localhost'
	port = ENV['MONGO_RUBY_DRIVER_PORT'] || MongoClient::DEFAULT_PORT
	client  = MongoClient.new(host, port, :pool_size => 35, :pool_timeout => 5)
	local = client.db('local')
	indiv = local.create_collection('indiv_flattened')

	previous_end_time = Time.now
	results.each do |row|
		beginning_time = Time.now

		indiv.insert(row)

		end_time = Time.now
		totalProcessed += 1
		this_time = (end_time - beginning_time)

		if totalProcessed > 1
			this_time += (beginning_time - previous_end_time)
		end

		previous_end_time = end_time

		total_time += this_time
		average_time = total_time / totalProcessed

		seconds_remaining = (totalRows - totalProcessed) * average_time

		say_ok "*** #{row['id']} - #{format("%02d:%02d:%02d", seconds_remaining / (60 * 60), (seconds_remaining / 60) % 60, seconds_remaining % 60)} remaining (#{(this_time*1000).round(2)}ms)"

	end
	
  end
end
