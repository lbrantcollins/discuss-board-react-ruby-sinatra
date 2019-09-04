class Comment < ActiveRecord::Base

	belongs_to :student
	has_one :student

	belongs_to :snippet
	has_one :snippet

	has_one :observation
	
end