class Challenge < ActiveRecord::Base

	has_many :challenge_keywords

	has_many :keywords, through: :challenge_keywords

	has_many :challenge_languages

	has_many :languages, through: :challenge_languages

	
end