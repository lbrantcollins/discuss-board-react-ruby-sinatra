class Teacher < ActiveRecord::Base

	has_many :challenges

	has_many :responses

	has_many :observations

	belongs_to :user
	
end