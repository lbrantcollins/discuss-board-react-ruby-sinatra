require 'sinatra/base'

# controllers
require './controllers/ApplicationController'
require './controllers/UserController'
require './controllers/StudentController'
require './controllers/TeacherController'
require './controllers/ChallengeController'
require './controllers/KeywordController'
require './controllers/ChallengeKeywordController'
require './controllers/LanguageController'
require './controllers/ChallengeLanguageController'
require './controllers/QuestionController'
require './controllers/ResponseController'
require './controllers/SnippetController'
require './controllers/CommentController'
require './controllers/ObservationController'


# models
require './models/UserModel'
require './models/StudentModel'
require './models/TeacherModel'
require './models/ChallengeModel'
require './models/KeywordModel'
require './models/ChallengeKeywordModel'
require './models/LanguageModel'
require './models/ChallengeLanguageModel'
require './models/QuestionModel'
require './models/ResponseModel'
require './models/SnippetModel'
require './models/CommentModel'
require './models/ObservationModel'


# top-level routing
# specify which controllers are used when

map ('/') {
	run ApplicationController
}

map ('/users') {
	run UserController
}

map ('/students') {
	run StudentController
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

map ('/challengekeywords') {
	run ChallengeKeywordController
}

map ('/languages') {
	run LanguageController
}

map ('/challengelanguages') {
	run ChallengeLanguageController
}

map ('/questions') {
	run QuestionController
}

map ('/responses') {
	run ResponseController
}

map ('/snippets') {
	run SnippetController
}

map ('/comments') {
	run CommentController
}

map ('/observations') {
	run ObservationController
}


