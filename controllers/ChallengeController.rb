require 'json'

class ChallengeController < ApplicationController

	before do
		if request.post? or request.patch? or request.put? 
			payload_body = request.body.read
			@payload = JSON.parse(payload_body).symbolize_keys
			puts "---------> Here's our payload: "
			pp @payload
		end
	end

	get '/test' do
		"you hit the /challenges/test route"
	end

	# INDEX/get: show all challenges
	########### 
	get '/' do
		# get all items from DB
		challenges = Challenge.all
		return challenges.to_json
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
		Challenge.create({
			teacher_id: @payload[:teacher_id],
			title: @payload[:title],
			description: @payload[:description],
		})
		return 201
	end

	# SHOW/get: show one challenge
	###########
	get '/:id' do
		challenge = Challenge.find params[:id]
		return [200, challenge.to_json]
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
	end

	# DELETE/destroy: delete a challenge 
	###########
#?????????????????????????????????????????????????????????????????????????
	# this deletes all associated questions, snippets, comments, observations
	delete '/:id' do
		challenge = Challenge.find params[:id]
		# does this delete the associated Qs, snippets, comments, observations?
		challenge.destroy
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
		return challenges.to_json
	end


end