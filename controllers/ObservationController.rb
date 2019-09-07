require 'json'

class ObservationController < ApplicationController

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
		@payload = JSON.parse(request.body.read).symbolize_keys
		observation = Observation.create({
			comment_id: @payload[:comment_id],
			teacher_id: @payload[:teacher_id],
			observation: @payload[:observation]
		})
		[201, observation.to_json]
	end
	
	# EDIT/get: 
	###########
	# React will provide and "edit observation" button

	# UPDATE/put: update/modify an observation
	###########
	put '/:id' do
		observation = Observation.find params[:id]

		@payload = JSON.parse(request.body.read).symbolize_keys
		observation[:comment_id] = @payload[:comment_id]
		observation[:teacher_id] = @payload[:teacher_id]
		observation[:observation] = @payload[:observation]

		observation.save
		[200, observation.to_json]
	end
	
	# DELETE/destroy: remove an observation to a COMMENT
	###########
	delete '/:id' do
		observation = Observation.find params[:id]
		observation.destroy  
	end

end