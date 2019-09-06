require 'json'

# allow multi-record create for efficiency
require 'activerecord-import'

# keywords associated with a specific challenge

class ChallengeKeywordController < ApplicationController

	get '/test' do
		"you hit the /challengekeywords/test route"
	end

	# INDEX/get: show all keywords for a specific challenge
	###########
	get '/:challenge_id' do
		keywords = ChallengeKeyword.where(challenge_id: params[:challenge_id])
		[200, keywords.to_json]
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
		[200, keyword.to_json]
	end

	# CREATE/post: add keyword(s) to an existing challenge
	###########
	post '/' do
		# payload must be an array of objects
		# each with properties of challenge_id and keyword_id
		payload = JSON.parse(request.body.read)
		# 'activerecord-import' module batch inserts to DB (efficiency)
		challenges = ChallengeKeyword.import(payload)
		# do NOT return the result of .import 
		# this is a known bug (feature?) of the activerecord-import gem
		# .import does not return a string (or stringified hash)
		# So, I'll just return the status code:
		[200, challenges.to_json]
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

	# DELETE: remove several keywords from a challenge
	###########
	delete '/' do
		# payload must be an array of through-table ids
		payload = JSON.parse(request.body.read)
		keywords = ChallengeKeyword.where(id: payload)
		# destroy "in_batches" for batch removal from DB (efficiency)
		keywords.in_batches(of: 1000).destroy_all
	end

end