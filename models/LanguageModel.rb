class Language < ActiveRecord::Base
	
	has_many :challenge_languages

	has_many :challenges, through: :challenge_languages
	
end