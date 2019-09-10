require 'json'

class UserController < ApplicationController

	get '/test' do
		"you hit the /users/test route"
	end

	# React will show login form
	# do the login
	post '/login' do
		@payload = JSON.parse(request.body.read).symbolize_keys
		user = User.find_by username: @payload[:username]

		pw = @payload[:password]

		# binding.pry
		##########
		# check username and password
		##########
		if user && user.authenticate(pw)
			session[:logged_in] = true
			session[:username] = user.username
			session[:message] = {
				success: true,
				status: "good",
			}
		else
			session[:message] = {
				success: false,
				status: "bad",
				message: "Invalid username or password."
			}
		end

		[200, user.to_json]
		
	end

	# CREATE/post: 
	###########
	# React will show a registration form
	post '/register' do
		@payload = JSON.parse(request.body.read).symbolize_keys
		
		# check username is unique
		user = User.find_by username: @payload[:username]
		
		if !user

			user = User.new 

			# if "has_secure_password" is specified in the User model
			# then, the .password setter method will automatically encrypt
			# the password and store it in "password_digest" on the User model
			user.username = @payload[:username]
			user.password = @payload[:password]
			user.is_teacher = @payload[:is_teacher]

			user.save

			# user = User.create({
			# 	username: @payload[:username],
			# 	password: @payload[:password],
			# 	is_teacher: @payload[:is_teacher],
			# })

			session[:logged_in] = true
			session[:username] = user.username
			session[:message] = {
				success: true,
				status: "good",
				message: "Welcome, #{user.username}"
			}

		else
			session[:message] = {
				success: false,
				status: "bad",
				message: "Sorry, username #{params[:username]} is already taken."
			}
		end

		##########
		# hash password
		##########

		[201, user.to_json]
	end


	# logout
	get '/logout' do
		username = session[:username]

		session.destroy

		session[:message] = {
			success: true,
			status: "neutral",
			message: "#{username} is now logged out."
		}

	end




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