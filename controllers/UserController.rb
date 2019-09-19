require 'json'

class UserController < ApplicationController

	before do
		if request.post? or request.patch? or request.put? 
			payload_body = request.body.read
			@payload = JSON.parse(payload_body).symbolize_keys
			puts "---------> Here's our payload: "
			pp @payload
		end
	end

	get '/test' do
		"you hit the /users/test route"
	end

	# Log user in
	#################
	# React will show login form
	post '/login' do

		# check if username exists
		user = User.find_by username: @payload[:username]
		# grab the hashed password
		pw = @payload[:password]

		# check username and password
		if user && user.authenticate(pw) # bcrypt

			# send back messages and user info
			session[:logged_in] = true
			session[:username] = user.username

			p session

			response = {
				code: 200,
				success: true,
				status: "good",
				message: "Welcome, #{user.username}.",
				id: user.id,
				username: user.username,
				is_teacher: user.is_teacher
			}.to_json

		else
			# send back "failure" message
			response = {
				code: 401,
				success: false,
				status: "bad",
				message: "Invalid username or password."
			}.to_json
		end		
	end



	# CREATE/post: Register a user
	###########
	# React will show a registration form
	post '/register' do
		
		# check if username already exists
		user = User.find_by username: @payload[:username]
		
		# if username not already taken...
		if !user

			# create a new user
			user = User.new 
			user.username = @payload[:username]
			user.is_teacher = @payload[:is_teacher]
			
			# since "has_secure_password" is specified in the User model
			# then, the .password setter method will automatically encrypt
			# the password and store it in "password_digest" on the User model
			
			# So, this hashes the password, really! so simple!
			user.password = @payload[:password]
			
			# save the new user to the DB
			user.save

			session[:logged_in] = true
			session[:username] = user.username
			# return "success" message, other session and user info
			response = {
				code: 201,
				success: true,
				status: "good",
				message: "Welcome, #{user.username}.",
				id: user.id,
				username: user.username,
				is_teacher: user.is_teacher
			}.to_json

		else
			# since username already exists, return "failure" message
			response = {
				code: 401,
				success: false,
				status: "bad",
				message: "Sorry, username #{params[:username]} is already taken."
			}.to_json

		end
	end


	# logout
	get '/logout' do
		# grab the username before destroying the session
		username = session[:username]

		session.destroy

		# now use "username" variable to send personalized logout message
		response = {
			success: true,
			status: 'neutral',
			message: "#{username} is now logged out."
		}
		[200, response.to_json]

	end

end