require 'json'

# keywords associated with a specific challenge

class ChallengeKeywordController < ApplicationController

	get '/' do
		"you hit the /challenge_keywords route"
	end

	# NEW/get form to add a keyword to a specific challenge
	###########
	get '/new' do
		"you hit the /challenge_keywords/new route"
		# Want to render a dropdown with keywords available
		# (not already used on the current challenge)
		# [even though the CREATE route below protects against doubles]
		# So, would just get keywords assoc with challenge
		# ...which is actually the same as the INDEX/get route above
	end

	# INDEX/get all keywords for a specific challenge
	###########
	get '/:challenge_id' do
		keywords = ChallengeKeyword.where(challenge_id: params[:challenge_id])
		return keywords.to_json
	end
	
	# SHOW/get one keyword from a challenge
	###########
	# NOTE: NOT LIKELY TO NEED THIS ROUTE
	get '/:challenge_id/:keyword_id' do
		keyword = ChallengeKeyword.where(
			challenge_id: params[:challenge_id],			
			keyword_id: params[:keyword_id]
		)
		return keyword.to_json
	end

	# CREATE/post a keyword to a specific challenge
	###########
	post '/:challenge_id/:keyword_id' do
		# do not add a keyword to a challenge if already associated
		existing_keywords = ChallengeKeyword.where(challenge_id: params[:challenge_id])
		existing_keyword_ids = []
		existing_keywords.each do |keyword|
			existing_keyword_ids.push(keyword.keyword_id)
		end
		if existing_keyword_ids.include?(params[:keyword_id].to_i)
			# the keyword is already associated with this challenge
			puts "keyword_id #{params[:keyword_id]} is already included on challenge #{params[:challenge_id]}."
		else
			# add the keyword (since NOT already associated with this challenge)
			ChallengeKeyword.create(
				challenge_id: params[:challenge_id], 
				keyword_id: params[:keyword_id]
			)
		end
	end

	# EDIT/get a keyword on a specific challenge
	###########
	# NOT NEEDED (keywords are edited on the keyword_choices table)

	# UPDATE/put an updated keyword on a specific challenge
	###########
	# NOT NEEDED (keywords are updated on the keyword_choices table)

	# DELETE/destroy a specific keyword from a specific challenge
	###########
	delete '/:challenge_id/:keyword_id' do
		keyword = ChallengeKeyword.where(
			challenge_id: params[:challenge_id],
			keyword_id: params[:keyword_id]
		).first
		
		keyword.delete
	end


end