require 'json'

class StudentController < ApplicationController

	before do
		if request.post? or request.patch? or request.put? 
			payload_body = request.body.read
			@payload = JSON.parse(payload_body).symbolize_keys
			puts "---------> Here's our payload: "
			pp @payload
		end
	end

	get '/test' do
		"you hit the /teachers/test route"
	end

	# INDEX/get: probably not needed
	########### 
	get '/' do
		students = Student.all
		return students.to_json
	end

	# NEW/get: not needed
	###########
	
	# SHOW/get: not needed
	###########

	# CREATE/post: add item with student_id when a student registers
	###########
	# send the user as the payload (we just need their id)
	post '/' do
		Student.create({
			student_id: @payload[:id]
		})
	end

	# EDIT/get: not needed
	###########

	# UPDATE/put: not needed
	###########
	
	# DELETE/destroy: not needed (keep even if student leaves the site)
	# since their posts are anonymous to other users anyway
	###########

end