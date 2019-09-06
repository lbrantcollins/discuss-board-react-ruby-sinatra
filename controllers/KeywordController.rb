require 'json'

# list of keywords teachers can associate with challenges

class KeywordController < ApplicationController

	get '/test' do
		"you have reached the /keywords/test route"
	end

	# INDEX/get list of all available keywords
	########### 
	get '/' do
		keywords = Keyword.all
		p keywords.to_json
		keywords.to_json
	end

	# NEW/get form to add a keyword to the list of available keywords
	###########
	get '/new' do
		"you hit the /keywords/new route"
		# React will provide the form without
		# needing to be prompted by this route
	end

	# SHOW/get: not needed
	###########

	# CREATE/post: add a keyword to the list of available keywords
	###########
	post '/' do
		payload = JSON.parse(request.body.read)
		keyword = Keyword.create({
			keyword: payload[:keyword]
		})
		[200, keyword]
	end
	
	# EDIT/get form change an existing keyword 
	###########
	# React will provide the form

	# UPDATE/put: update/modify an existing keyword 
	###########
	# NOTE: This will change the keyword on ALL past posts too
	# Probably should warn the user about that
	put '/:id' do
		keyword = Keyword.find params[:id]

		payload = JSON.parse(request.body.read)
		keyword[:keyword] = payload[:keyword]

		keyword.save
	end

	# DELETE/destroy a keyword 
	###########
	# NOTE: This will remove the keyword from ALL past posts too
	# Probably should warn the user about that
	delete '/:id' do
		keyword = ChallengeKeyword.find params[:id]
		keyword.destroy
	end


end