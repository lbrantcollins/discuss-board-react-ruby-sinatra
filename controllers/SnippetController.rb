require 'json'

class SnippetController < ApplicationController

	before do
		if request.post? or request.patch? or request.put? 
			payload_body = request.body.read
			@payload = JSON.parse(payload_body).symbolize_keys
			puts "---------> Here's our payload: "
			pp @payload
		end
	end

	get '/test' do
		"you hit the /snippets/test route"
	end

	# INDEX/get: list the only snippet for a CHALLENGE
	########### 
	get '/challenge/:challenge_id' do
		snippet = Snippet.where(challenge_id: params[:challenge_id])
		return [200, snippet.to_json]
	end

	# INDEX/get: list all snippets by a STUDENT
	########### 
	get '/student/:student_id' do
		snippets = Snippet.where(student_id: params[:student_id])
		return [200, snippets.to_json]
	end

	# NEW/get: 
	###########
	# React will provide an "add snippet" button
	
	# SHOW/get: 
	###########
	# not needed

	# CREATE/post: student will post a new snippet
	###########
	post '/' do
		Snippet.create({
			challenge_id: @payload[:challenge_id],
			language_id: @payload[:language_id],
			student_id: @payload[:student_id],
			snippet: @payload[:snippet],
			substantial: false,
		})
		return 201
	end
	

	# EDIT/get: 
	###########
	# React will provide and "edit snippet" button

	# UPDATE/put: update/modify a snippet
	###########
	put '/:id' do
		snippet = Snippet.find params[:id]

		snippet[:challenge_id] = @payload[:challenge_id]
		snippet[:language_id] = @payload[:language_id]
		snippet[:student_id] = @payload[:student_id]
		snippet[:snippet] = @payload[:snippet]
		snippet[:substantial] = @payload[:substantial]

		snippet.save
	end
	
	# DELETE/destroy: remove a snippet from a CHALLENGE
	###########
#?????????????????????????????????????????????????????????????????????????
	delete '/:id' do
		snippet = Snippet.find params[:id]
		# does this delete the associated comments/observations?
		snippet.destroy  
	end

end