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

map ('/api/v1') {
	run ApplicationController
}

map ('/api/v1/users') {
	run UserController
}

map ('/api/v1/students') {
	run StudentController
}

map ('/api/v1/teachers') {
	run TeacherController
}

map ('/api/v1/challenges') {
	run ChallengeController
}

map ('/api/v1/keywords') {
	run KeywordController
}

map ('/api/v1/challengekeywords') {
	run ChallengeKeywordController
}

map ('/api/v1/languages') {
	run LanguageController
}

map ('/api/v1/challengelanguages') {
	run ChallengeLanguageController
}

map ('/api/v1/questions') {
	run QuestionController
}

map ('/api/v1/responses') {
	run ResponseController
}

map ('/api/v1/snippets') {
	run SnippetController
}

map ('/api/v1/comments') {
	run CommentController
}

map ('/api/v1/observations') {
	run ObservationController
}


