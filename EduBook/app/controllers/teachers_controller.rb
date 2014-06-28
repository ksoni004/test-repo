class TeachersController < ApplicationController

	def login_form
		if !session[:teacher].nil?
			@teacher = Teacher.where(:email => session[:teacher]).first
			#for badge_count
			teacher = Teacher.where(:email=>session[:teacher]).first
			t1 = Teacher.find(teacher).id
			c1 = Course.where(:teacher_id=>t1).all.entries
			@my_count = 0
			c1.each do |c|
				x = c.documents.count
				@my_count = @my_count + x
		 	end
			t = Teacher.all
		 	@total_count=0
		 	t.each do |a|
		 		c = Course.where(:teacher_id=>a.id).all.entries
		 		c.each do |b|
		 			z = b.documents.count
		 			@total_count = @total_count + z
		 		end
		 	end
			render 'teachers/profile'
		else
			render 'teachers/login_form'
		end
	end

	def login
		@teacher = Teacher.authenticate(params[:email], params[:password])
		if @teacher==nil
			flash[:alert]="Login not successful..!! Please check email and password."
			redirect_to :back
		else
			session[:teacher] = @teacher.email
			#for badge_count
			teacher = Teacher.where(:email=>session[:teacher]).first
			t1 = Teacher.find(teacher).id
			c1 = Course.where(:teacher_id=>t1).all.entries
			@my_count = 0
			c1.each do |c|
				x = c.documents.count
				@my_count = @my_count + x
		 	end
			t = Teacher.all
		 	@total_count=0
		 	t.each do |a|
		 		c = Course.where(:teacher_id=>a.id).all.entries
		 		c.each do |b|
		 			z = b.documents.count
		 			@total_count = @total_count + z
		 		end
		 	end
			render 'teachers/profile'
		end
	end

	def profile
		@teacher = Teacher.where(:email=>session[:teacher]).first
		if @teacher.email==session[:teacher]
			#for badge_count
			teacher = Teacher.where(:email=>session[:teacher]).first
			t1 = Teacher.find(teacher).id
			c1 = Course.where(:teacher_id=>t1).all.entries
			@my_count = 0
			c1.each do |c|
				x = c.documents.count
				@my_count = @my_count + x
		 	end
			t = Teacher.all
		 	@total_count=0
		 	t.each do |a|
		 		c = Course.where(:teacher_id=>a.id).all.entries
		 		c.each do |b|
		 			z = b.documents.count
		 			@total_count = @total_count + z
		 		end
		 	end
			render 'teachers/profile'
		else
			redirect_to :login_page
		end
	end

	def signup_form
		render 'teachers/signup_form'
	end

	def signup
		teacher = Teacher.new
		Teacher.email = params[:email]
		Teacher.password = params[:password]
		Teacher.name = params[:name]
		Teacher.surname = params[:surname]
		teacher.save
		if teacher.id == nil
			render :text => 'Invalid Signup'
		else
			flash[:notice]="Signup Successful, Continue to login"
			redirect_to :login_page
		end
	end

	def upload_file
			@teacher = Teacher.where(:email => session[:teacher]).first
			t = Teacher.find(@teacher).id
			@courses = Course.where(:teacher_id=>t).all.entries
			#for badge_count
			teacher = Teacher.where(:email=>session[:teacher]).first
			t1 = Teacher.find(teacher).id
			c1 = Course.where(:teacher_id=>t1).all.entries
			@my_count = 0
			c1.each do |c|
				x = c.documents.count
				@my_count = @my_count + x
		 	end
			t = Teacher.all
		 	@total_count=0
		 	t.each do |a|
		 		c = Course.where(:teacher_id=>a.id).all.entries
		 		c.each do |b|
		 			z = b.documents.count
		 			@total_count = @total_count + z
		 		end
		 	end

			render 'teachers/upload_file'
	end

	def file_uploaded
		if !session[:teacher].nil? and session[:teacher]==params[:email]
			doc = Document.new
			doc.course_id = params[:course]
			doc.comment = params[:comment]
			doc.avatar = params[:avatar]
			doc.save
			flash[:notice]="File Uploaded Successfully....!!!!"
			redirect_to :upload
		end
	end

	def add_course
		@semesters = Semester.all
		@teacher = Teacher.where(:email=>session[:teacher]).first
		if @teacher.email==session[:teacher]
			#for badge_count
			teacher = Teacher.where(:email=>session[:teacher]).first
			t1 = Teacher.find(teacher).id
			c1 = Course.where(:teacher_id=>t1).all.entries
			@my_count = 0
			c1.each do |c|
				x = c.documents.count
				@my_count = @my_count + x
		 	end
			t = Teacher.all
		 	@total_count=0
		 	t.each do |a|
		 		c = Course.where(:teacher_id=>a.id).all.entries
		 		c.each do |b|
		 			z = b.documents.count
		 			@total_count = @total_count + z
		 		end
		 	end
			render 'teachers/add_course'
		else
			redirect_to :login_page
		end
	end

	def course_added
		course = Course.new
		course.teacher_id = params[:t_id]
		course.course_name = params[:course_name]
		course.save

		params[:semesters].each do |semester|
			s = Semester.find(semester)
			course.semesters.push(s)
		end
		flash[:notice]="Course Added Successfully....!!!!"
		redirect_to :add_course

	end

	def logout
		session[:teacher] = nil
		render 'teachers/login_form'
	end

	def download_file
		@b = Document.find(24)
		#response.headers["Content-Type"] = "application/pdf; charset=utf-8"
		#send_data pdf_bytes, :disposition => 'inline', :type => 'application/pdf'
		#send_file(@b.avatar.path, :type => 'application/pdf', :disposition_attachment => 'inline')
		#render 'teachers/download_file'
	end

	def uploads
		@teacher = Teacher.where(:email=>session[:teacher]).first
		t = Teacher.find(@teacher).id
		@courses = Course.where(:teacher_id=>t).all.entries
		@my_count = 0
		@courses.each do |c|
			x = c.documents.count
			@my_count = @my_count + x
	 	end
	 	t = Teacher.all
	 	@total_count=0
	 	t.each do |a|
	 		c = Course.where(:teacher_id=>a.id).all.entries
	 		c.each do |b|
	 			z = b.documents.count
	 			@total_count = @total_count + z
	 		end
	 	end
		render 'teachers/uploads'
	end

	def remove_file
		Document.find(params[:document_id]).destroy
		flash[:notice]="Removed Successfully....!!!!"
		redirect_to :back
	end

	def overall_uploads
		
		@teachers = Teacher.all
		@courses = []
		@teachers.each do |teacher|
			t = Teacher.find(teacher.id)
			c = t.courses
			a = teacher.name
			@courses << c
		end
		#for badge_count
		teacher = Teacher.where(:email=>session[:teacher]).first
		t1 = Teacher.find(teacher).id
		c1 = Course.where(:teacher_id=>t1).all.entries
		@my_count = 0
		c1.each do |c|
			x = c.documents.count
			@my_count = @my_count + x
	 	end
		t = Teacher.all
	 	@total_count=0
	 	t.each do |a|
	 		c = Course.where(:teacher_id=>a.id).all.entries
	 		c.each do |b|
	 			z = b.documents.count
	 			@total_count = @total_count + z
	 		end
	 	end
		render 'teachers/overall_uploads'
	end

	def welcome
		render 'teachers/welcome', :layout => "welcome"
	end
end
