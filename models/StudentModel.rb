class Student < ActiveRecord::Base

	has_many :questions

	has_many :snippets

	has_many :comments
	
	belongs_to :user

end