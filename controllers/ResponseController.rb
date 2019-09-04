require 'json'

class ResponseController < ApplicationController

	before do
		if request.post? or request.patch? or request.put? 
			payload_body = request.body.read
			@payload = JSON.parse(payload_body).symbolize_keys
			puts "---------> Here's our payload: "
			pp @payload
		end
	end

	get '/test' do
		"you hit the /responses/test route"
	end

	# INDEX/get: list the one response for a QUESTION
	########### 
	get '/question/:question_id' do
		response = Response.where(question_id: params[:question_id])
		return [200, response.to_json]
	end

	# NEW/get: 
	###########
	# React will provide an "add response" button
	
	# SHOW/get: 
	###########
	# not needed

	# CREATE/post: teacher will post a new response to a QUESTION
	###########
	post '/' do
		Response.create({
			question_id: @payload[:question_id],
			teacher_id: @payload[:teacher_id],
			response: @payload[:response]
		})
		return 201
	end
	
	# EDIT/get: 
	###########
	# React will provide and "edit response" button

	# UPDATE/put: update/modify a response
	###########
	put '/:id' do
		response = Response.find params[:id]

		response[:question_id] = @payload[:question_id]
		response[:teacher_id] = @payload[:teacher_id]
		response[:response] = @payload[:response]

		response.save
	end
	
	# DELETE/destroy: remove a response to a QUESTION
	###########
	delete '/:id' do
		response = Response.find params[:id]
		response.destroy  
	end

end