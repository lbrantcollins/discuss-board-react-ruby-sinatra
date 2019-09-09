class Snippet < ActiveRecord::Base

	belongs_to :challenge

	belongs_to :student

	belongs_to :language
	
	has_many :comments
	
end



