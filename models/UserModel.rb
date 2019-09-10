class User < ActiveRecord::Base

	has_secure_password
	
	has_one :teacher

	has_one :student
	
end