class Language < ActiveRecord::Base
	
	has_many :challenge_languages, dependent: :destroy

	has_many :challenges, through: :challenge_languages

	has_many :snippets
	
end