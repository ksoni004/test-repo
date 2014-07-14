class Student < ActiveRecord::Base
	has_many :feedbacks
	validates :email, :uniqueness => true
	
	def self.authenticate(email, password)
		student = Student.where(:email => email, :password => password).first
		return student
	end
end