require 'json'

class QuestionController < ApplicationController

	before do
		if request.post? or request.patch? or request.put? 
			payload_body = request.body.read
			@payload = JSON.parse(payload_body).symbolize_keys
			puts "---------> Here's our payload: "
			pp @payload
		end
	end

	get '/test' do
		"you hit the /questions/test route"
	end

	# INDEX/get: 
	########### 

	# NEW/get: 
	###########
	
	# SHOW/get: 
	###########

	# CREATE/post: 
	###########
	

	# EDIT/get: 
	###########

	# UPDATE/put: 
	###########
	
	# DELETE/destroy: 
	###########

end