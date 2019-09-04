require 'json'

class CommentController < ApplicationController

	before do
		if request.post? or request.patch? or request.put? 
			payload_body = request.body.read
			@payload = JSON.parse(payload_body).symbolize_keys
			puts "---------> Here's our payload: "
			pp @payload
		end
	end

	get '/test' do
		"you hit the /comments/test route"
	end

	# INDEX/get: list all comments for a SNIPPET
	########### 
	get '/snippet/:snippet_id' do
		comments = Comment.where(snippet_id: params[:snippet_id])
		return [200, comments.to_json]
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
	
	# SHOW/get: 
	###########
	# not needed

	# CREATE/post: student will post a new comment
	###########
	post '/' do
		Comment.create({
			snippet_id: @payload[:snippet_id],
			student_id: @payload[:student_id],
			comment: @payload[:comment],
			substantial: false,
		})
		return 201
	end
	

	# EDIT/get: 
	###########
	# React will provide and "edit comment" button

	# UPDATE/put: update/modify a comment
	###########
	put '/:id' do
		comment = Comment.find params[:id]

		comment[:snippet_id] = @payload[:snippet_id]
		comment[:student_id] = @payload[:student_id]
		comment[:comment] = @payload[:comment]
		comment[:substantial] = @payload[:substantial]

		comment.save
		})
	end
	
	# DELETE/destroy: remove a comment (and associated teacher observation)
	###########
#???????????????????????????????????????????????????????????????
	delete '/:id' do
		comment = Comment.find params[:id]
		# does this delete the associate teacher observation?
		comment.destroy  
	end

end