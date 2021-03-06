require 'json'

class SnippetController < ApplicationController

	before do
		# @payload: instantiated variable for request.body data
		if request.post? or request.patch? or request.put? 
			payload_body = request.body.read
			@payload = JSON.parse(payload_body).symbolize_keys
			puts "---------> Here's our payload: "
			pp @payload
		end

		puts "********* logged in inside SnippetController?"
		p session[:logged_in]

		# only logged-in users can get to any of these routes
		# if !session[:logged_in]
	 #      halt 403, {
	 #        success: false,
	 #        status: 'bad',
	 #        code: 403, # forbidden
	 #        message: "You are not logged in"
	 #      }.to_json
  #   	end
	end

	get '/test' do
		"you hit the /snippets/test route"
	end

	# INDEX/get: list the snippets for a CHALLENGE
	########### 
	get '/challenge/:challenge_id' do
		snippetList = Snippet.where(challenge_id: params[:challenge_id])
		# binding.pry
		snippets = snippetList.map do |snippet|
			{
				id: snippet.id,
				challenge_id: params[:challenge_id],
				student_id: snippet.student_id,
				snippet: snippet.snippet,
				substantial: snippet.substantial,
				date_posted: snippet.date_posted,
				language: snippet.language,
			}
		end
		response = {
				code: 200,
				success: true,
				status: "good",
				message: "list of snippets successfully returned",
				snippets: snippets
		}
		return response.to_json
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
		puts "ready to find the snippet"
		snippet = Snippet.find params[:id]
		puts " found the snippet"

		snippet[:snippet] = @payload[:snippet]
		puts "updated the snippet"

		snippet.save
		puts "saved the snippet"

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