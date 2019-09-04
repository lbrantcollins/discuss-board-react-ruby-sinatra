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

	# INDEX/get: list all questions for a CHALLENGE
	########### 
	get '/challenge/:challenge_id' do
		questions = Question.where(challenge_id: params[:challenge_id])
		return [200, questions.to_json]
	end

	# INDEX/get: list all questions by a STUDENT
	########### 
	get '/student/:student_id' do
		questions = Question.where(student_id: params[:student_id])
		return [200, questions.to_json]
	end

	# NEW/get: 
	###########
	# React will provide an "add question" button
	
	# SHOW/get: 
	###########
	# not needed

	# CREATE/post: student will post a new question
	###########
	post '/' do
		Question.create({
			challenge_id: @payload[:challenge_id],
			student_id: @payload[:student_id],
			question: @payload[:question],
			substantial: false,
		})
		return 201
	end
	

	# EDIT/get: 
	###########
	# React will provide and "edit question" button

	# UPDATE/put: update/modify a question
	###########
	put '/:id' do
		question = Question.find params[:id]

		question[:challenge_id] = @payload[:challenge_id]
		question[:student_id] = @payload[:student_id]
		question[:question] = @payload[:question]
		question[:substantial] = @payload[:substantial]

		question.save
	end
	
	# DELETE/destroy: remove a question (and associated teacher response)
	###########
#?????????????????????????????????????????????????????????????????????????
	delete '/:id' do
		question = Question.find params[:id]
		# does this delete the associated teacher response?
		question.destroy  
	end

end