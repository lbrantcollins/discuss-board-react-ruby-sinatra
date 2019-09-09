# extend the sinatra-base module

class ApplicationController < Sinatra::Base
	require 'bundler'
	Bundler.require()

	# enable sessions
	enable :sessions

	# set up our DB connection
	# we will come back to this later for production/deployment environs
	ActiveRecord::Base.establish_connection(
		:adapter => 'postgresql',
		:database => 'discuss'
	)

	# Set up CORS
  	register Sinatra::CrossOrigin

	configure do
    	enable :cross_origin
  	end

  	set :allow_origin, :any
  	set :allow_methods, [:get, :post, :put, :options, :patch, :delete, :head]
  	set :allow_credentials, true

	# teach controller to find templates
	set :views, File.expand_path('../../views', __FILE__)

	# teach controller to find static assets
	set :public_dir, File.expand_path('../../public', __FILE__)

	# I shouldn't need method override since using fetch in React
	# use Rack::MethodOverride # use Rack middleware
	# set :method_override, true # turn on method override for Sinatra

	# as a part of CORS, some browsers send OPTIONS requests first to check
  	# what they're allowed to do, this is our response to that check
  	options '*' do
    	response.headers["Allow"] = "HEAD,GET,PUT,PATCH,POST,DELETE,OPTIONS"
    	response.headers["Access-Control-Allow-Headers"] = "X-Requested-Wtih, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"
    	200
  	end

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

	get '*' do
		response = " Oops! That page does not exist: "
		300.times { response += " 404"}
		response # figure out how to set a status on this reponse
		# in express: res.status(404).send('404 page not found')
	end


end