require 'json'

# languages associated with a specific challenge

class ChallengeLanguageController < ApplicationController

	get '/test' do
		"you hit the /challengelanguages/test route"
	end

	# INDEX/get: show all languages for a specific challenge
	###########
	get '/:challenge_id' do
		languages = ChallengeLanguage.where(challenge_id: params[:challenge_id])
		[200, languages.to_json]
	end

	# NEW/get: form to add a language to a specific challenge
	###########
	get '/new' do
		"you hit the /challengelanguages/new route"
		# Want to render a dropdown with languages available
		# (not already used on the current challenge)
	end
	
	# SHOW/get: show one language from a challenge
	###########
	# NOTE: NOT LIKELY TO NEED THIS ROUTE
	get '/:challenge_id/:language_id' do
		language = ChallengeLanguage.where(
			challenge_id: params[:challenge_id],			
			language_id: params[:language_id]
		)
		[200, language.to_json]
	end

	# CREATE/post: add language(s) to an existing challenge
	###########
	post '/' do
		# payload must be an array of objects
		# each with properties of challenge_id and language_id
		payload = JSON.parse(request.body.read)
		# 'activerecord-import' module batch inserts to DB (efficiency)
		challenges = ChallengeLanguage.import(payload)
		# do NOT return the result of .import 
		# this is a known bug (feature?) of the activerecord-import gem
		# .import does not return a string (or stringified hash)
		# So, I'll just return the status code:
		[201, challenges.to_json]
	end

	# EDIT/get: not needed
	###########
	# NOT NEEDED (languages are updated on languages table, LanguageController)

	# UPDATE/put: not needed
	###########
	# NOT NEEDED (languages are updated on languages table, LanguageController)

	# DELETE: remove a language from a challenge
	###########
	delete '/:challenge_id/:language_id' do
		language = ChallengeLanguage.where(
			challenge_id: params[:challenge_id],			
			language_id: params[:language_id]
		).first
		# not "destroy" since language and challenge are not being deleted
		language.delete
	end

	# DELETE: remove several languages from a challenge
	###########
	delete '/' do
		# payload must be an array of through-table ids
		payload = JSON.parse(request.body.read)
		languages = ChallengeLanguage.where(id: payload)
		# destroy "in_batches" for batch removal from DB (efficiency)
		languages.in_batches(of: 1000).destroy_all
	end

end