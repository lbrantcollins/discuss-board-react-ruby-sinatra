class ChallengeKeyword < ActiveRecord::Base

	belongs_to :challenge
	
	belongs_to :keyword
	
end