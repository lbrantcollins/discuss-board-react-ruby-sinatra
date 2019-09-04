class Observation < ActiveRecord::Base

	belongs_to :comment
	has_one :comment

	belongs_to :teacher
	has_one :teacher
	
end