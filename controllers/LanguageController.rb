require 'json'

# list of languages teachers can associate with challenges

class LanguageController < ApplicationController

	get '/test' do
		"you have reached the /languages/test route"
	end

	# INDEX/get list of all available languages
	########### 
	get '/' do
		languages = Language.all
		[200, languages.to_json]
	end

	# NEW/get form to add a language to the list of available languages
	###########
	get '/new' do
		"you hit the /languages/new route"
		# React will provide the form without
		# needing to be prompted by this route
	end

	# SHOW/get: not needed
	###########

	# CREATE/post: add a language to the list of available languages
	###########
	post '/' do
		payload = JSON.parse(request.body.read)
		language = Language.create({
			language: payload["language"]
		})
		[201, language.to_json]
	end
	
	# EDIT/get form change an existing language 
	###########
	# React will provide the form

	# UPDATE/put: update/modify an existing language 
	# NOT USING THIS ROUTE: CAN ONLY ADD OR DELETE
	###########
	# NOTE: This will change the language on ALL past posts too
	# Probably should warn the user about that
	put '/:id' do
		language = Language.find params[:id]

		payload = JSON.parse(request.body.read)
		language[:language] = payload["language"]

		language.save
		[200, language.to_json]
	end

	# DELETE/destroy language(s) when given an array of language ids 
	###########
	# NOTE: This removes language(s) from ALL challenges too
	# That is, also removed from challenge-language thru table
	# Probably should warn the user about that!!
	delete '/' do
		# payload must be an array of language table ids
		payload = JSON.parse(request.body.read)
		languages = Language.where(id: payload)
		# destroy "in_batches" for batch removal from DB (efficiency)
		languages.in_batches(of: 1000).destroy_all
	end

	# DELETE/destroy a language 
	###########
	# NOTE: This removes the language from ALL past posts too
	# Probably should warn the user about that
	delete '/:id' do
		language = Language.find params[:id]
		language.destroy
	end


end