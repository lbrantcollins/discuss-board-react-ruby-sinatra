require 'json'

class TeacherController < ApplicationController

	get '/test' do
		"you hit the teacher controller"
	end

	# index

	get '/' do
		teachers = Teacher.all
		return teachers.to_json
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