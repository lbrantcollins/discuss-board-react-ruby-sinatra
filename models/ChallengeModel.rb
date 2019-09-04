class Challenge < ActiveRecord::Base

	belongs_to :teacher
	has_one :teacher
	
	has_many :challenge_keywords
	has_many :keywords, through: :challenge_keywords

	has_many :challenge_languages
	has_many :languages, through: :challenge_languages

	has_many :questions

	
end