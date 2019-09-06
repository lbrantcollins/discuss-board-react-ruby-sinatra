require 'json'

# languages associated with a specific challenge

class LanguageController < ApplicationController

	get '/test' do
		"you hit the /languages/test route"
	end

	# return alphabetical list of all available languages
	get '/' do
		language_entries = Language.all
		languages = []
		language_entries.map do |entry|
			languages.push(entry.language)
		end
		return (languages.sort).to_json
	end

	# NEW/get form to add a language 
	###########
	get '/new' do
		"you hit the /languages/new route"
		# React will provide the form without
		# needing to be prompted by this route
	end

	# INDEX/get all languages for a specific challenge (alphabetically)
	###########
	get '/:challenge_id' do
		language_entries = ChallengeLanguage.where(challenge_id: params[:challenge_id])
		languages = []
		language_entries.map do |entry|
			languages.push(entry.language)
		end
		return (languages.sort).to_json
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