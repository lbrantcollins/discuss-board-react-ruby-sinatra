class Question < ActiveRecord::Base

	belongs_to :challenge
	has_one :challenge

	belongs_to :student
	has_one :student

	belongs_to :language
	has_one :language
	
end