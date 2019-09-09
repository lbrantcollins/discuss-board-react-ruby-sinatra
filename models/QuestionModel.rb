class Question < ActiveRecord::Base

	belongs_to :challenge

	belongs_to :student

	has_one :response
	
end