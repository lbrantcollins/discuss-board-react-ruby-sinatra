require 'json'

class SnippetController < ApplicationController

	get '/test' do
		"you hit the /snippets/test route"
	end

	# INDEX/get: list the snippets for a CHALLENGE
	########### 
	get '/challenges/:challenge_id' do
		snippets = Snippet.where(challenge_id: params[:challenge_id])
		return [200, snippets.to_json]
	end

	# INDEX/get: list all snippets by a STUDENT
	########### 
	get '/students/:student_id' do
		snippets = Snippet.where(student_id: params[:student_id])
		return [200, snippets.to_json]
	end

	# NEW/get: 
	###########
	# React will provide an "add snippet" button
	
	# SHOW/get: Get one snippet by id
	###########
	get '/:id' do
		snippet = Snippet.find params[:id]
		# binding.pry
		response = {
			challenge_id: snippet.challenge_id,
			language_id: snippet.language_id,
			student_id: snippet.student_id,
			snippet: snippet.snippet,
			substantial: snippet.substantial,
			language: snippet.language.language,
			title: snippet.challenge.title,
			description: snippet.challenge.description,
			teacher: snippet.challenge.teacher.user.username,
		}
		return [200, response.to_json]
	end

	# CREATE/post: student will post a new snippet
	###########
	post '/' do
		@payload = JSON.parse(request.body.read).symbolize_keys
		snippet = Snippet.create({
			challenge_id: @payload[:challenge_id],
			language_id: @payload[:language_id],
			student_id: @payload[:student_id],
			snippet: @payload[:snippet],
			substantial: false,
		})
		[201, snippet.to_json]
	end
	

	# EDIT/get: 
	###########
	# React will provide and "edit snippet" button

	# UPDATE/put: update/modify a snippet
	###########
	put '/:id' do
		snippet = Snippet.find params[:id]

		@payload = JSON.parse(request.body.read).symbolize_keys
		snippet[:challenge_id] = @payload[:challenge_id]
		snippet[:language_id] = @payload[:language_id]
		snippet[:student_id] = @payload[:student_id]
		snippet[:snippet] = @payload[:snippet]
		snippet[:substantial] = @payload[:substantial]

		snippet.save
		[200, snippet.to_json]
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