class User < ActiveRecord::Base

	has_many :teachers

	has_many :students

	
end