require 'json'

class UserController < ApplicationController

	get '/test' do
		"you hit the /users/test route"
	end

	# React will show login form
	# do the login
	post '/login' do
		
	end

	# CREATE/post: 
	###########
	# React will show a registration form
	post '/register' do
		@payload = JSON.parse(request.body.read).symbolize_keys
		user = User.create({
			username: @payload[:username],
			password: @payload[:password],
			is_teacher: @payload[:is_teacher],
		})
		[201, user.to_json]
	end


	# logout




	# INDEX/get: 
	########### 

	# NEW/get: 
	###########
	
	# SHOW/get: 
	###########

	# CREATE/post: 
	###########
	post '/' do
		@payload = JSON.parse(request.body.read).symbolize_keys

		201
	end

	

	# EDIT/get: 
	###########

	# UPDATE/put: 
	###########
	
	# DELETE/destroy: 
	###########

end