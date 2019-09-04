require 'json'

class ObservationController < ApplicationController

	before do
		if request.post? or request.patch? or request.put? 
			payload_body = request.body.read
			@payload = JSON.parse(payload_body).symbolize_keys
			puts "---------> Here's our payload: "
			pp @payload
		end
	end

	get '/test' do
		"you hit the /observations/test route"
	end

	# INDEX/get: list the one observation for a COMMENT
	########### 
	get '/:comment_id' do
		observation = Observation.where(comment_id: params[:comment_id])
		return [200, observation.to_json]
	end

	# NEW/get: 
	###########
	# React will provide an "add observation" button
	
	# SHOW/get: 
	###########
	# not needed

	# CREATE/post: teacher will post a new observation to a COMMENT
	###########
	post '/' do
		Observation.create({
			comment_id: @payload[:comment_id],
			teacher_id: @payload[:teacher_id],
			observation: @payload[:observation]
		})
		return 201
	end
	
	# EDIT/get: 
	###########
	# React will provide and "edit observation" button

	# UPDATE/put: update/modify an observation
	###########
	put '/:id' do
		observation = Observation.find params[:id]

		observation[:comment_id] = @payload[:comment_id]
		observation[:teacher_id] = @payload[:teacher_id]
		observation[:observation] = @payload[:observation]

		observation.save
	end
	
	# DELETE/destroy: remove an observation to a COMMENT
	###########
	delete '/:id' do
		observation = Observation.find params[:id]
		observation.destroy  
	end

end