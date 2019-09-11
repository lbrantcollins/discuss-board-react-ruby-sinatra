require 'json'



class QuestionController < ApplicationController

	before do

    	if !session[:logged_in]
	      halt 403, {
	        success: false,
	        status: 'bad',
	        code: 403, # forbidden
	        message: "You are not logged in"
	      }.to_json
    	end

	end

	get '/test' do
		"you hit the /questions/test route"
	end

	# INDEX/get: list all questions for a CHALLENGE
	########### 
	get '/questions/:challenge_id' do
		questions = Question.where(challenge_id: params[:challenge_id])
		[200, questions.to_json]
	end

	# INDEX/get: list all questions by a STUDENT
	########### 
	get '/questions/:student_id' do
		questions = Question.where(student_id: params[:student_id])
		[200, questions.to_json]
	end

	# NEW/get: 
	###########
	# React will provide an "add question" button
	
	# SHOW/get: get one question by id
	###########
	get '/questions/:id' do
		question = Question.find params[:id]
		[200, question.to_json]
	end

	# CREATE/post: student will post a new question
	###########
	post '/' do
		@payload = JSON.parse(request.body.read).symbolize_keys
		question = Question.create({
			challenge_id: @payload[:challenge_id],
			student_id: @payload[:student_id],
			question: @payload[:question],
			substantial: false,
		})
		[201, question.to_json]
	end
	

	# EDIT/get: 
	###########
	# React will provide and "edit question" button

	# UPDATE/put: update/modify a question
	###########
	put '/:id' do
		question = Question.find params[:id]

		@payload = JSON.parse(request.body.read).symbolize_keys
		question[:challenge_id] = @payload[:challenge_id]
		question[:student_id] = @payload[:student_id]
		question[:question] = @payload[:question]
		question[:substantial] = @payload[:substantial]

		question.save
		[200, question.to_json]
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