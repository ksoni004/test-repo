class StudentsController < ApplicationController

	def login_form
		if !session[:student].nil?
			@student = Student.where(:email => session[:student]).first
			render 'students/profile'
		else
			render 'students/login_form'
		end
	end

	def login
		@student = Student.authenticate(params[:email], params[:password])
		if @student==nil
			flash[:alert]="Login not successful..!! Please check email and password."
			redirect_to :back
		else
			session[:student] = @student.email
			#for badge_count
			t = Teacher.all
		 	@total_count=0
		 	t.each do |a|
		 		c = Course.where(:teacher_id=>a.id).all.entries
		 		c.each do |b|
		 			z = b.documents.count
		 			@total_count = @total_count + z
		 		end
		 	end
			render 'students/profile'
		end
	end

	def profile
		@student = Student.where(:email=>session[:student]).first
		if @student.email==session[:student]
			#for badge_count
			t = Teacher.all
		 	@total_count=0
		 	t.each do |a|
		 		c = Course.where(:teacher_id=>a.id).all.entries
		 		c.each do |b|
		 			z = b.documents.count
		 			@total_count = @total_count + z
		 		end
		 	end
			render 'students/profile'
		else
			redirect_to :student_login_page
		end
	end

	def signup_form
		render 'students/signup_form'
	end

	def signup
		student = Student.new
		student.email = params[:email]
		student.password = params[:password]
		student.name = params[:name]
		student.surname = params[:surname]
		student.save
		if student.id == nil
			render :text => 'Invalid Signup'
		else
			flash[:notice]="Signup Successful, Continue to login"
			redirect_to :student_login_page
		end
	end

	def logout
		session[:student] = nil
		render 'students/login_form'
	end

	def total_uploads
		
		@teachers = Teacher.all
		@courses = []
		@teachers.each do |teacher|
			t = Teacher.find(teacher.id)
			c = t.courses
			a = teacher.name
			@courses << c
		end
		#for badge_count
		t = Teacher.all
	 	@total_count=0
	 	t.each do |a|
	 		c = Course.where(:teacher_id=>a.id).all.entries
	 		c.each do |b|
	 			z = b.documents.count
	 			@total_count = @total_count + z
	 		end
	 	end
		render 'students/total_uploads'
	end

end
