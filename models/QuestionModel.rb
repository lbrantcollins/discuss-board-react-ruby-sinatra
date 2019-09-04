class Question < ActiveRecord::Base

	belongs_to :student
	has_one :student

	belongs_to :challenge
	has_one :challenge

	has_one :answer
	
end