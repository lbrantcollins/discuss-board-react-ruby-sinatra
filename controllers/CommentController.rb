require 'json'

class CommentController < ApplicationController

	get '/test' do
		"you hit the /comments/test route"
	end

	# INDEX/get: list all comments (not needed)
	########### 
	get '/' do
		comments = Comment.all
		return [200, comments.to_json]
	end

	# INDEX/get: list all comments for a SNIPPET 
	# and include the instructor's observation, if any
	########### 
	get '/snippet/:snippet_id' do
		commentList = Comment.where(snippet_id: params[:snippet_id])
		# binding.pry
		comments = commentList.map do |comment|
			{
				parent_id: params[:snippet_id],
				remark_id: comment.id,
				remark: comment.comment,
				student_id: comment.student_id,
				remark_date: comment.date_posted,
				response_id: comment.observation == nil ? nil : comment.observation.id,
				response: comment.observation == nil ? nil : comment.observation.observation,
				teacher_id: comment.observation == nil ? nil : comment.observation.teacher_id,
				response_date: comment.observation == nil ? nil : comment.observation.date_posted,
			}		
		end
		response = {
			code: 200,
			success: true,
			status: "good",
			message: "list of comments (and observations) successfully returned",
			remarks: comments
		}
		return response.to_json
	end

	# INDEX/get: list all comments for a STUDENT
	########### 
	get '/student/:student_id' do
		comments = Comment.where(student_id: params[:student_id])
		return [200, comments.to_json]
	end

	# NEW/get: 
	###########
	# React will provide an "add comment" button
	
	# SHOW/get: get one coment by id
	###########
	get '/:id' do
		comment = Comment.find params[:id]
		[200, comment.to_json]
	end

	# CREATE/post: student will post a new comment
	###########
	post '/' do
		@payload = JSON.parse(request.body.read).symbolize_keys
		comment = Comment.create({
			snippet_id: @payload[:snippet_id],
			student_id: @payload[:student_id],
			comment: @payload[:comment],
			substantial: false,
		})
		[201, comment.to_json]
	end
	

	# EDIT/get: 
	###########
	# React will provide and "edit comment" button

	# UPDATE/put: update/modify a comment
	###########
	put '/:id' do
		comment = Comment.find params[:id]

		@payload = JSON.parse(request.body.read).symbolize_keys
		comment[:snippet_id] = @payload[:snippet_id]
		comment[:student_id] = @payload[:student_id]
		comment[:comment] = @payload[:comment]
		comment[:substantial] = @payload[:substantial]

		comment.save
		[200, comment.to_json]
	end
	
	# DELETE/destroy: remove a comment (and associated teacher observation)
	###########
#?????????????????????????????????????????????????????????????????????????
	delete '/:id' do
		comment = Comment.find params[:id]
		# does this delete the associated teacher observation?
		comment.destroy  
	end

end