require 'json'

# languages associated with a specific challenge

class LanguageController < ApplicationController

	get '/' do
		"you hit the /languages route"
	end

	# NEW/get form to add a language to a specific challenge
	###########
	get '/new' do
		"you hit the /languages/new route"
		# Want to render a dropdown with languages available
		# (not already used on the current challenge)
		# [even though the CREATE route below protects against doubles]
		# So, would just get languages assoc with challenge
		# ...which is actually the same as the INDEX/get route above
	end

	# INDEX/get all languages for a specific challenge
	###########
	get '/:challenge_id' do
		languages = Language.where(challenge_id: params[:challenge_id])
		return languages.to_json
	end
	
	# SHOW/get one language from a challenge
	###########
	# NOTE: NOT LIKELY TO NEED THIS ROUTE
	get '/:challenge_id/:language_id' do
		language = Language.where(
			challenge_id: params[:challenge_id],			
			language_id: params[:language_id]
		)
		return language.to_json
	end

	# CREATE/post a language to a specific challenge
	###########
	post '/:challenge_id/:language_id' do
		# do not add a language to a challenge if already associated
		existing_languages = Language.where(challenge_id: params[:challenge_id])
		existing_language_ids = []
		existing_languages.each do |language|
			existing_language_ids.push(language.language_id)
		end
		if existing_language_ids.include?(params[:language_id].to_i)
			# the language is already associated with this challenge
			puts "language_id #{params[:language_id]} is already included on challenge #{params[:challenge_id]}."
		else
			# add the language (since NOT already associated with this challenge)
			Language.create(
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
		language = Language.where(
			challenge_id: params[:challenge_id],
			language_id: params[:language_id]
		).first
		
		language.delete
	end



end