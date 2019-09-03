require 'json'

# list of keyword choices to associate with challenges
# only available to teachers (not students)
# teachers can add keywords to the list
# CAUTION: if delete a keyword, that keyword will need to be 
# removed from any challenges where it was deployed
# Probaby should warn the user about that.

class KeywordController < ApplicationController

	get '/test' do
		"you have reached the /keywords/test route"
	end

	get '/' do
		keywords = Keyword.all
		return keywords.to_json
	end

	# NEW/get form to add a keyword to a specific challenge
	###########
	get '/new' do
		"you hit the /keywords/new route"
		# React will provide the form without
		# needing to be prompted by this route
	end

	# INDEX/get all keywords for a specific challenge
	###########
	get '/:challenge_id' do
		keywords = Keyword.where(challenge_id: params[:challenge_id])
		return keywords.to_json
	end
	
	# SHOW/get one keyword from a challenge
	###########
	# NOTE: NOT LIKELY TO NEED THIS ROUTE
	get '/:challenge_id/:keyword_id' do
		keyword = Keyword.where(
			challenge_id: params[:challenge_id],			
			keyword_id: params[:keyword_id]
		)
		return keyword.to_json
	end

	# CREATE/post a keyword to a specific challenge
	###########
	post '/:challenge_id/:keyword_id' do
		# do not add a keyword to a challenge if already associated
		existing_keywords = Keyword.where(challenge_id: params[:challenge_id])
		existing_keyword_ids = []
		existing_keywords.each do |keyword|
			existing_keyword_ids.push(keyword.keyword_id)
		end
		if existing_keyword_ids.include?(params[:keyword_id].to_i)
			# the keyword is already associated with this challenge
			puts "keyword_id #{params[:keyword_id]} is already included on challenge #{params[:challenge_id]}."
		else
			# add the keyword (since NOT already associated with this challenge)
			Keyword.create(
				challenge_id: params[:challenge_id], 
				keyword_id: params[:keyword_id]
			)
		end
	end

	# EDIT/get a keyword on a specific challenge
	###########
	# NOT NEEDED (keywords are edited on the keywords table)

	# UPDATE/put an updated keyword on a specific challenge
	###########
	# NOT NEEDED (keywords are updated on the keywords table)

	# DELETE/destroy a specific keyword from a specific challenge
	###########
	delete '/:challenge_id/:keyword_id' do
		keyword = Keyword.where(
			challenge_id: params[:challenge_id],
			keyword_id: params[:keyword_id]
		).first
		
		keyword.delete
	end


end