require 'json'

# keywords associated with a specific challenge

class ChallengeKeywordController < ApplicationController

	before do
		if request.post? or request.patch? or request.put? 
			payload_body = request.body.read
			@payload = JSON.parse(payload_body).symbolize_keys
			puts "---------> Here's our payload: "
			pp @payload
		end
	end

	get '/' do
		"you hit the /challengekeywords route"
	end

	# INDEX/get: show all keywords for a specific challenge
	###########
	get '/:challenge_id' do
		keywords = ChallengeKeyword.where(challenge_id: params[:challenge_id])
		return keywords.to_json
	end

	# NEW/get: form to add a keyword to a specific challenge
	###########
	get '/new' do
		"you hit the /challengekeywords/new route"
		# Want to render a dropdown with keywords available
		# (not already used on the current challenge)
	end
	
	# SHOW/get: show one keyword from a challenge
	###########
	# NOTE: NOT LIKELY TO NEED THIS ROUTE
	get '/:challenge_id/:keyword_id' do
		keyword = ChallengeKeyword.where(
			challenge_id: params[:challenge_id],			
			keyword_id: params[:keyword_id]
		)
		return keyword.to_json
	end

	# CREATE/post: add a new keyword to an existing challenge
	###########
	post '/' do
		# if dropdown screens out any keywords already assoc with the challenge,
		# (see the /new route), then no need to check if already exists
		ChallengeKeyword.create({
			challenge_id: @payload[:challenge_id],
			keyword_id: @payload[:keyword_id]
		})
	end

	# EDIT/get: not needed
	###########
	# NOT NEEDED (keywords are updated on keywords table, KeywordController)

	# UPDATE/put: not needed
	###########
	# NOT NEEDED (keywords are updated on keywords table, KeywordController)

	# DELETE: remove a keyword from a challenge
	###########
	delete '/:challenge_id/:keyword_id' do
		keyword = ChallengeKeyword.where(
			challenge_id: params[:challenge_id],			
			keyword_id: params[:keyword_id]
		).first
		# not "destroy" since keyword and challenge are not being deleted
		keyword.delete
	end

end