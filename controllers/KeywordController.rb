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
		[200, keywords.to_json]
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
			keyword: payload["keyword"]
		})
		[201, keyword.to_json]
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

		JSON.parse(request.body.read)
		keyword[:keyword] = payload[:keyword]

		keyword.save
		[200, keyword.to_json]
	end

	# DELETE/destroy keyword(s) from an array of ids 
	###########
	# NOTE: This SHOULD remove keyword(s) from ALL challenges too
	# That is, also removed from challenge-keyword thru table
	# Probably should warn the user about that!!
	delete '/' do
		# payload must be an array of keyword table ids
		payload = JSON.parse(request.body.read)
		keywords = Keyword.where(id: payload)
		# destroy "in_batches" for batch removal from DB (efficiency)
		keywords.in_batches(of: 1000).destroy_all
	end

	# DELETE/destroy a keyword 
	###########
	# NOTE: This SHOULD remove the keyword from ALL past posts too
	# Probably should warn the user about that
	delete '/:id' do
		keyword = Keyword.find params[:id]
		keyword.destroy
	end


end