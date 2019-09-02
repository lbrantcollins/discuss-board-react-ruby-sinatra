# extend the sinatra-base module

class ApplicationController < Sinatra::Base
	require 'bundler'
	Bundler.require()

	# set up our DB connection
	# we will come back to this later for production/deployment environs
	ActiveRecord::Base.establish_connection(
		:adapter => 'postgresql',
		:database => 'test_database'
	)

	# teach controller to find templates
	set :views, File.expand_path('../../views', __FILE__)

	# teach controller to find static assets
	set :public_dir, File.expand_path('../../public', __FILE__)


	get '/' do
		"<h1>Welcome to your first Sinatra MVC App.</h1>"
	end

	# here is why "pry" is amazing
	get '/test' do

		some_text = "Grow food. It'll change your life."

		# pry gem lets us use this command

		binding.pry

		# this pauses execution and opens a REPL
		# in the scope of this route at this exact spot in the code
		# inspect variables
		# test DB/ORM queries !!!!
		# etc.
		# be sure to type "exit" on terminal to resume execution back
		# because the client is still waiting for response from this route

		# CAUTION: Don't use "rerun bundle exec rackup" with "pry"
		# (just use "bundle exec rackup")

		# this response will be sent to client after you exit "pry"
		"pry is finished -- here's some_text: #{some_text}"

	end

	get '/hello' do
		erb :hello
	end


end