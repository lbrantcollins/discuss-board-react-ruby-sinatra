class Response < ActiveRecord::Base

	belongs_to :question
	has_one :question

	belongs_to :teacher
	has_one :teacher
	
end