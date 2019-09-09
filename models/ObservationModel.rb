class Observation < ActiveRecord::Base

	belongs_to :comment

	belongs_to :teacher
	
end