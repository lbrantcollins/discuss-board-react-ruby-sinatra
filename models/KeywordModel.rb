class Keyword < ActiveRecord::Base

	has_many :challenge_keywords

	has_many :challenges, through: :challenge_keywords

	
end