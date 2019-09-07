require 'json'

class UserController < ApplicationController

	get '/test' do
		"you hit the /users/test route"
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