require 'json'

# languages associated with a specific challenge

class ChallengeLanguageController < ApplicationController

	before do
		if request.post? or request.patch? or request.put? 
			payload_body = request.body.read
			@payload = JSON.parse(payload_body).symbolize_keys
			puts "---------> Here's our payload: "
			pp @payload
		end
	end

	get '/' do
		"you hit the /challenge_languages route"
	end

	# NEW/get form to add a language to a specific challenge
	###########
	get '/new' do
		"you hit the /challenge_languages/new route"
		# not needed
	end

	# CREATE/post to add a new language to an existing challenge
	###########
	post '/' do
		puts @payload
		puts "challenge_id = X#{@payload[:challenge_id]}X"
		puts "language_id = X#{@payload[:language_id]}X"

		ChallengeLanguage.create({
			challenge_id: @payload[:challenge_id],
			language_id: @payload[:language_id]
		})
	end

	# INDEX/get all languages for a specific challenge
	###########
	get '/:challenge_id' do
		languages = ChallengeLanguage.where(challenge_id: params[:challenge_id])
		return languages.to_json
	end
	
	# SHOW/get one language from a challenge
	###########
	# NOTE: NOT LIKELY TO NEED THIS ROUTE
	get '/:challenge_id/:language_id' do
		language = ChallengeLanguage.where(
			challenge_id: params[:challenge_id],			
			language_id: params[:language_id]
		)
		return language.to_json
	end

	# CREATE/post a language to a specific challenge
	###########
	post '/:challenge_id/:language_id' do
		# do not add a language to a challenge if already associated
		existing_languages = ChallengeLanguage.where(challenge_id: params[:challenge_id])
		existing_language_ids = []
		existing_languages.each do |language|
			existing_language_ids.push(language.language_id)
		end
		if existing_language_ids.include?(params[:language_id].to_i)
			# the language is already associated with this challenge
			puts "language_id #{params[:language_id]} is already included on challenge #{params[:challenge_id]}."
		else
			# add the language (since NOT already associated with this challenge)
			ChallengeLanguage.create(
				challenge_id: params[:challenge_id], 
				language_id: params[:language_id]
			)
		end
	end

	# EDIT/get a language on a specific challenge
	###########
	# NOT NEEDED (languages are edited on the language_choices table)

	# UPDATE/put an updated language on a specific challenge
	###########
	# NOT NEEDED (languages are updated on the language_choices table)

	# DELETE/destroy a specific language from a specific challenge
	###########
	delete '/:challenge_id/:language_id' do
		language = ChallengeLanguage.where(
			challenge_id: params[:challenge_id],
			language_id: params[:language_id]
		).first
		
		language.delete
	end



end