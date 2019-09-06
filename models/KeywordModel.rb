class Keyword < ActiveRecord::Base

	has_many :challenge_keywords, dependent: :destroy

	has_many :challenges, through: :challenge_keywords

	
end