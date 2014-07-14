class Teacher < ActiveRecord::Base
	has_many :feedbacks
	has_many :courses
	has_many :notifications
	validates :email, :uniqueness => true
	
	
	def self.authenticate(email, password)
		teacher = Teacher.where(:email => email, :password => password).first
		return teacher
	end


end