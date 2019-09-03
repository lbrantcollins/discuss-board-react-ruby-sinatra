require 'json'

# keywords for a specific challenge

class KeywordController < ApplicationController

	get '/' do
		"you hit the /keywords route"
	end

	# INDEX/get all keywords for a specific challenge
	get '/:challenge_id' do
		keywords = Keyword.where(challenge_id: params[:challenge_id])
		return keywords.to_json
	end
	
	# SHOW/get one keyword from a challenge
	# NOTE: NOT LIKELY TO NEED THIS ROUTE
	get '/:challenge_id/:keyword_id' do
		keyword = Keyword.where(
			challenge_id: params[:challenge_id],			
			keyword_id: params[:keyword_id]
		)
		return keyword.to_json
	end

	# NEW/get form to add a keyword to a specific challenge
	get '/new' do
		"you hit the /keywords/new route"
		# Want to render a dropdown with keywords available
		# (not already used on the current challenge)
		# [even though the CREATE route below protects against doubles]
		# So, would just get keywords assoc with challenge
		# ...which is the INDEX/get route above
	end

	# CREATE/post a keyword to a specific challenge
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
			# add the keyword (is NOT already associated with this challenge)
			Keyword.create(
				challenge_id: params[:challenge_id], 
				keyword_id: params[:keyword_id]
			)
		end
	end

	# EDIT/get a keyword on a specific challenge
	# NOT NEEDED (keywords are edited on the keyword_choices table)

	# UPDATE/put an updated keyword on a specific challenge
	# NOT NEEDED (keywords are updated on the keyword_choices table)

	# DELETE/destroy a specific keyword from a specific challenge
	delete '/:challenge_id/:keyword_id' do
		keyword = Keyword.where(
			challenge_id: params[:challenge_id],
			keyword_id: params[:keyword_id]
		).first
		
		keyword.delete
	end

	


	# # create
	# post '/' do
	# 	new_item = Item.new
	# 	new_item.content = params[:content]
	# 	new_item.save

	# 	redirect '/items'
	# end

	# # new

	# get '/new' do
	# 	erb :item_new
	# end


	# # edit

	# get '/:id/edit' do
	# 	@item = Item.find params[:id]
	# 	erb :item_edit
	# end

	# # show

	# get '/:id' do
	# 	@item = Item.find params[:id]
	# 	erb :item_show
	# end

	# # update

	# put '/:id' do
	# 	item = Item.find params[:id]
	# 	item.content = params[:content]
	# 	item.save

	# 	redirect '/items'
	# end

	# # delete

	# delete '/:id' do
	# 	item = Item.find params[:id]
	# 	item.destroy

	# 	redirect '/items'
	# end


end