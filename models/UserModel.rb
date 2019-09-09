class User < ActiveRecord::Base

	# has_many :teachers
	has_one :teacher

	# has_many :students
	has_one :student
	
end