class Teacher < ActiveRecord::Base

	has_many :challenges

	has_many :answers

	has_many :observations

	belongs_to :user
	has_one :user
	
end