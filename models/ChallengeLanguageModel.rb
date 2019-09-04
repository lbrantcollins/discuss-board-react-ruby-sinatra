class ChallengeLanguage < ActiveRecord::Base

	belongs_to :challenge
	
	belongs_to :language
	
end