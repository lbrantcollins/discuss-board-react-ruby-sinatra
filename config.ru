require 'sinatra/base'

# controllers
require './controllers/ApplicationController'
require './controllers/TeacherController'
require './controllers/ChallengeController'
require './controllers/KeywordController'
require './controllers/LanguageController'



# models
require './models/TeacherModel'
require './models/ChallengeModel'
require './models/KeywordModel'
require './models/LanguageModel'


# top-level routing
# specify which controllers are used when

map ('/') {
	run ApplicationController
}

map ('/teachers') {
	run TeacherController
}

map ('/challenges') {
	run ChallengeController
}

map ('/keywords') {
	run KeywordController
}

map ('/languages') {
	run LanguageController
}