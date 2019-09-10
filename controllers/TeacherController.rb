require 'json'

class TeacherController < ApplicationController

	get '/test' do
		"you hit the /teachers/test route"
	end

	# INDEX/get: probably not needed
	########### 
	get '/' do
		teachers = Teacher.all
		[200, teachers.to_json]
	end

	# NEW/get: not needed
	###########
	
	# SHOW/get: not needed
	###########

	# CREATE/post: add item with teacher_id when a teacher registers
	###########
	# send the user as the payload (we just need their id)
	post '/' do
		@payload = JSON.parse(request.body.read).symbolize_keys
		teacher = Teacher.create({
			user_id: @payload[:user_id]
		})
		[201, teacher.to_json]
	end

	# EDIT/get: not needed
	###########

	# UPDATE/put: not needed
	###########
	
	# DELETE/destroy: not needed (keep even if teacher leaves the site)
	###########

end