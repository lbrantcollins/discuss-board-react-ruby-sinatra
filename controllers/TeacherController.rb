require 'json'

class TeacherController < ApplicationController

	before do
		if request.post? or request.patch? or request.put? 
			payload_body = request.body.read
			@payload = JSON.parse(payload_body).symbolize_keys
			puts "---------> Here's our payload: "
			pp @payload
		end
	end

	get '/test' do
		"you hit the teacher controller"
	end

	# INDEX/get: probably not needed
	########### 
	get '/' do
		teachers = Teacher.all
		return teachers.to_json
	end

	# NEW/get: not needed
	###########
	
	# SHOW/get: not needed
	###########

	# CREATE/post: add item with teacher_id when a teacher registers
	###########
	# send the user as the payload (we just need their id)
	post '/' do
		teacher = {
			teacher_id: @payload[:id]
		}
	end

	# EDIT/get: not needed
	###########

	# UPDATE/put: not needed
	###########
	

	# DELETE/destroy: not needed (keep even if teacher leaves the site)
	###########

end