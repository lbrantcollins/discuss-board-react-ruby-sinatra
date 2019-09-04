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

	get '/test' do
		"you hit the /challengelanguages/test route"
	end

	# INDEX/get: show all languages for a specific challenge
	###########
	get '/:challenge_id' do
		languages = ChallengeLanguage.where(challenge_id: params[:challenge_id])
		return languages.to_json
	end

	# NEW/get form to add a language to a specific challenge
	###########
	get '/new' do
		"you hit the /challengelanguages/new route"
		# Want to render a dropdown with languages available
		# (not already used on the current challenge)
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

	# CREATE/post to add a new language to an existing challenge
	###########
	# if dropdown screens out any languages already assoc with the challenge,
	# (see the /new route), then no need to check if already exists
	post '/' do
		ChallengeLanguage.create({
			challenge_id: @payload[:challenge_id],
			language_id: @payload[:language_id]
		})
	end

	# EDIT/get: not needed
	###########
	# NOT NEEDED (languages are updated on languages table, LanguageController)

	# UPDATE/put: not needed
	###########
	# NOT NEEDED (languages are updated on languages table, LanguageController)

	# DELETE/destroy a specific language from a specific challenge
	###########
	delete '/:challenge_id/:language_id' do
		language = ChallengeLanguage.where(
			challenge_id: params[:challenge_id],
			language_id: params[:language_id]
		).first
		# not "destroy" since language and challenge are not being deleted
		language.delete
	end

end