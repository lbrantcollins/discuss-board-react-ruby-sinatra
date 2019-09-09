class Comment < ActiveRecord::Base

	belongs_to :student

	belongs_to :snippet

	has_one :observation


	
end