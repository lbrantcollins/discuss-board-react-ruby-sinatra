require 'sinatra/base'

# controllers
require './controllers/ApplicationController'
require './controllers/TeacherController'
require './controllers/ChallengeController'
require './controllers/KeywordController'
require './controllers/ChallengeKeywordController'
require './controllers/LanguageController'
require './controllers/ChallengeLanguageController'



# models
require './models/TeacherModel'
require './models/ChallengeModel'
require './models/KeywordModel'
require './models/ChallengeKeywordModel'
require './models/LanguageModel'
require './models/ChallengeLanguageModel'


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

map ('/challenge_keywords') {
	run ChallengeKeywordController
}

map ('/languages') {
	run LanguageController
}

map ('/challenge_languages') {
	run ChallengeLanguageController
}