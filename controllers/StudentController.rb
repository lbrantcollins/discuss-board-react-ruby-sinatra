require 'json'

class StudentController < ApplicationController

	get '/test' do
		"you hit the /students/test route"
	end

	# INDEX/get: probably not needed
	########### 
	get '/' do
		students = Student.all
		[200, students.to_json]
	end

	# NEW/get: not needed
	###########
	
	# SHOW/get: not needed
	###########

	# CREATE/post: add item with student_id when a student registers
	###########
	# send the user as the payload (we just need their id)
	post '/' do
		@payload = JSON.parse(request.body.read).symbolize_keys
		student = Student.create({
			user_id: @payload[:user_id]
		})
		[200, student.to_json]
	end

	# EDIT/get: not needed
	###########

	# UPDATE/put: not needed
	###########
	
	# DELETE/destroy: not needed (keep even if student leaves the site)
	# since their posts are anonymous to other users anyway
	###########

end