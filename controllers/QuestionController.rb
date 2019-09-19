require 'json'



class QuestionController < ApplicationController

	before do
		# @payload: instantiated variable for request.body data
		if request.post? or request.patch? or request.put? 
			payload_body = request.body.read
			@payload = JSON.parse(payload_body).symbolize_keys
			puts "---------> Here's our payload: "
			pp @payload
		end

		puts "logged in inside QuestionController?"
		p session[:logged_in]
		
		# only logged-in users can get to any of these routes
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
	# and include the instructor's response, if any
	########### 
	get '/challenge/:challenge_id' do
		questionList = Question.where(challenge_id: params[:challenge_id])
		questions = questionList.map do |question|
			{
				parent_id: params[:challenge_id],
				remark_id: comment.id,
				remark: question.question,
				student_id: question.student_id,
				remark_date: question.date_posted,
				response_id: question.response == nil ? nil : question.response.id,
				response: question.response == nil ? nil : question.response.observation,
				teacher_id: question.response == nil ? nil : question.response.teacher_id,
				response_date: question.response == nil ? nil : question.response.date_posted,
			}		
		end
		response = {
				code: 200,
				success: true,
				status: "good",
				message: "list of questions (and responses) successfully returned",
				remarks: questions
		}
		return response.to_json
	end

	# INDEX/get: list all comments for a SNIPPET 
	# would love to include the instructor's observation, if any
	########### 
	get '/snippet/:snippet_id' do
		comments = Comment.where(snippet_id: params[:snippet_id])
		# binding.pry
		response = comments.map do |comment|
			{
				id: comment.id,
				comment: comment.comment,
				student_id: comment.student_id,
				comment_date: comment.date_posted,
				observation_id: comment.observation == nil ? nil : comment.observation.id,
				observation: comment.observation == nil ? nil : comment.observation.observation,
				teacher_id: comment.observation == nil ? nil : comment.observation.teacher_id,
				observation_date: comment.observation == nil ? nil : comment.observation.date_posted,
			}		
		end
		p response
		[200, response.to_json]
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