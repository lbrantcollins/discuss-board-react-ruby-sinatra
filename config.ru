require 'sinatra/base'

# controllers
require './controllers/ApplicationController'
require './controllers/ItemController'


# models
require './models/ItemModel'


# top-level routing
# specify which controllers are used when

map ('/') {
	run ApplicationController
}

map ('/items') {
	run ItemController
}