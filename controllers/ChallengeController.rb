require 'json'

class ChallengeController < ApplicationController

	before do
		# @payload: instantiated variable for request.body data
		if request.post? or request.patch? or request.put? 
			payload_body = request.body.read
			@payload = JSON.parse(payload_body).symbolize_keys
			puts "---------> Here's our payload: "
			pp @payload
		end

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
		"you hit the /challenges/test route"
	end

	# INDEX/get: show all challenges
	########### 
	get '/' do
		# get all challenges from DB
		challengeList = Challenge.all
		# binding.pry

		# attach the keywords and languages to each challenge
		challenges = challengeList.map do |challenge|
			{
				id: challenge.id,
				title: challenge.title,
				description: challenge.description,
				keywords: challenge.keywords,
				languages: challenge.languages,
			}
		end

		response = {
				code: 200,
				success: true,
				status: "good",
				message: "list of challenges successfully returned",
				challenges: challenges
		}

		response.to_json
	end


	# NEW/get: show form to add a new challenge
	###########
	get '/new' do
		"you hit the /challenges/new route"
		# React will provide the form without
		# needing to be prompted by this route
	end

	# CREATE/post: add a new challenge
	###########
	post '/' do
		challenge = Challenge.create({
			teacher_id: @payload[:teacher_id],
			title: @payload[:title],
			description: @payload[:description],
		})
		# respond with status and the new challenge
		response = {
			code: 201,
			success: true,
			status: "good",
			message: "Successfully created new challenge ##{challenge.id}",
			challenge: challenge,
		}
		response.to_json
	end

	# SHOW/get: show one challenge
	###########
	get '/:id' do
		challenge = Challenge.find params[:id]

		# binding.pry

		# respond with status and the located challenge
		response = {
			code: 201,
			success: true,
			status: "good",
			message: "Successfully retrieved challenge ##{challenge.id}",
			id: challenge.id,
			title: challenge.title,
			description: challenge.description,
			teacher_id: challenge.teacher_id,
		}
		response.to_json
	end

   # EDIT/get: show form to edit an existing challenge
	###########
	get '/:id/edit' do
		"you hit the /challenges/:id/edit route"
		# React will provide a link to the form without
		# needing to be prompted by this route
	end

	# UPDATE/put: update an existing challenge into the DB
	###########
	put '/:id' do
		challenge = Challenge.find params[:id]

		challenge[:teacher_id] = @payload[:teacher_id]
		challenge[:title] = @payload[:title]
		challenge[:description] = @payload[:description]

		challenge.save	

		# respond with status and the updated challenge
		response = {
			code: 200,
			success: true,
			status: "good",
			message: "Successfully updated challenge ##{challenge.id}",
			challenge: challenge,
		}
		response.to_json
	end

	# DELETE/destroy: delete a challenge 
	###############################
	# this deletes all associated questions, snippets, comments, observations
	###############################
	delete '/:id' do
		challenge = Challenge.find params[:id]

		challenge.destroy

		# respond with status and the deleted challenge
		response = {
			code: 200,
			success: true,
			status: "neutral",
			message: "Successfully deleted challenge ##{params[:id]}",
			challenge: challenge,
		}
		response.to_json
	end

	# find all KEYWORDS and LANGUAGES for a challenge
	#############################################################

	# INDEX/get: show all keywords for one challenge (alphabetically)
	###########
	get '/:id/keywords' do
		keyword_hashes = (Challenge.find params[:id]).keywords
		keywords = []
		keyword_hashes.map do |keyword_hash|
			keywords.push(keyword_hash.keyword)
		end
		return (keywords.sort).to_json
	end

	# INDEX/get: show all languages for one challenge
	###########
	get '/:id/languages' do
		language_hashes = (Challenge.find params[:id]).languages
		languages = []
		language_hashes.map do |language_hash|
			languages.push(language_hash.language)
		end
		return (languages.sort).to_json
	end

	# find all challenges for a TEACHER
	#############################################################
	# INDEX/get: show all challenges for one teacher
	###########
	get '/teacher/:id' do
		challenges = Challenge.where(teacher_id: params[:id])
		[200, challenges.to_json]
	end


end