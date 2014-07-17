class TeachersController < ApplicationController

	def welcome
		render 'teachers/welcome', :layout => "welcome_layout"
	end

	def login_form
		if !session[:teacher].nil?
			@teacher = Teacher.where(:email => session[:teacher]).first
			#for badge_count
			document_count
			render 'teachers/profile', :layout => "teachers_layout"
		else
			render 'teachers/login_form'
		end
	end

	def login
		@teacher = Teacher.authenticate(params[:email], params[:password])
		if @teacher==nil
			flash[:alert]="Login not successful..!! Please check email and password."
			redirect_to :back, :layout => "teachers_layout"
		else
			session[:teacher] = @teacher.email
			#for badge_count
			document_count
			render 'teachers/profile', :layout => "teachers_layout"
		end
	end

	def profile
		@teacher = Teacher.where(:email=>session[:teacher]).first
		if @teacher.email==session[:teacher]
			#for badge_count
			document_count
			render 'teachers/profile', :layout => "teachers_layout"
		else
			redirect_to :login_page, :layout => "teachers_layout"
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
			document_count
			render 'teachers/upload_file', :layout => "teachers_layout"
	end

	def file_uploaded
		if !session[:teacher].nil? and session[:teacher]==params[:email]
			doc = Document.new
			doc.course_id = params[:course]
			doc.comment = params[:comment]
			doc.avatar = params[:avatar]
			doc.save
			flash[:notice]="File Uploaded Successfully....!!!!"
			redirect_to :upload, :layout => "teachers_layout"
		end
	end

	def add_course
		@semesters = Semester.all
		@teacher = Teacher.where(:email=>session[:teacher]).first
		if @teacher.email==session[:teacher]
			#for badge_count
			document_count
			render 'teachers/add_course', :layout => "teachers_layout"
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
		flash[:notice]="Subject Added Successfully....!!!!"
		redirect_to :add_course, :layout => "teachers_layout"

	end

	def logout
		session[:teacher] = nil
		render 'teachers/login_form'
	end

	def uploads
		t = Teacher.where(:email=>session[:teacher]).first.id
		@teacher_name = Teacher.find(t).name
		@documents = Document.order("created_at ASC").joins("INNER JOIN courses ON courses.id = documents.course_id").where("courses.teacher_id=?", t).select("documents.*, courses.course_name as course_name").paginate(:page => params[:page], :per_page => 6)
		document_count
		render 'teachers/uploads', :layout => "teachers_layout"
	end

	def remove_file
		Document.find(params[:document_id]).destroy
		document_count
		flash[:notice]="Removed Successfully....!!!!"
		redirect_to :back, :layout => "teachers_layout"
	end

	def overall_uploads
		@documents = Document.order("created_at ASC").joins("INNER JOIN courses ON courses.id = documents.course_id").joins("INNER JOIN teachers ON teachers.id = courses.teacher_id").select("documents.*,courses.course_name as course_name, teachers.name as teacher_name").paginate(:page => params[:page], :per_page => 6)
		#for badge_count
		document_count
		render 'teachers/overall_uploads', :layout => "teachers_layout"
	end
 
	def overall_post
		if !params["id"].nil?
			document = Document.find(params["id"].to_i)
			document.counter = document.counter + 1
			document.save
			render :json=>document.counter, :status=> 200
		else
			render :json=>{ "success" => true}, :status=> 400
		end
	end

	def my_courses
		t = Teacher.where(:email=>session[:teacher]).first.id
		@courses = Course.where(:teacher_id=>t).all.entries
		#for badge_count
		document_count
		render 'teachers/my_courses', :layout => "teachers_layout"
	end

	def add_notification
		@semesters = Semester.all
		teacher = Teacher.where(:email=>session[:teacher]).first
		if teacher.email==session[:teacher]
			document_count
			render 'teachers/add_notification', :layout => "teachers_layout"
		else
			redirect_to :login_page
		end
	end

	def notification_added
		t = Teacher.where(:email=>session[:teacher]).first.id
		params[:semesters].each do |semester|
			notification = Notification.new
			notification.comment = params[:comment]
			notification.teacher_id = t
			notification.semester = semester
			notification.save
		end
		flash[:notice6]="Notification Added Successfully....!!!!"
		redirect_to :notification, :layout => "teachers_layout"
	end
	
	def my_notifications
		document_count
		t = Teacher.where(:email=>session[:teacher]).first.id
		@teacher_name = Teacher.find(t).name
		@teacher_surname = Teacher.find(t).surname
		@notifications = Notification.order("created_at ASC").joins("INNER JOIN semesters ON semesters.id = notifications.semester").where("notifications.teacher_id=?", t).select("notifications.*, semesters.year as year, semesters.branch as branch, semesters.semester_type as semester_type").paginate(:page => params[:page], :per_page => 5)
		render 'teachers/my_notification', :layout => "teachers_layout"
	end

	def overall_notifications
		document_count
		@notifications = Notification.order("created_at ASC").joins("INNER JOIN semesters ON semesters.id = notifications.semester").joins("INNER JOIN teachers ON teachers.id = notifications.teacher_id").select("notifications.*, semesters.year as year, semesters.branch as branch,semesters.semester_type as semester_type, teachers.name as teacher_name,teachers.surname as teacher_surname").paginate(:page => params[:page], :per_page => 5)
		render 'teachers/overall_notification', :layout => "teachers_layout"
	end

	def remove_notification
		Notification.find(params[:notification_id]).destroy
		flash[:notice]="Removed Successfully....!!!!"
		document_count
		redirect_to :back, :layout => "teachers_layout"
	end

	def password
		teacher = Teacher.where(:email => session[:teacher]).first	
		@pass = teacher.password
		@flash = "Wrong Password"
		@dialog="Password Updated Successfully....!!!!"
		document_count
		render 'teachers/change_password', :layout => "teachers_layout"
	end

	def change_password
		teacher = Teacher.where(:email => session[:teacher]).first	
		Teacher.find(teacher.id).update(:password => params[:renter_password])
		flash[:notice]="Password Updated Successfully....!!!!"
		redirect_to :back, :layout => "teachers_layout"
	end
	
	def t_add_feedback
		document_count
		render 'teachers/t_feedback', :layout => "teachers_layout"
	end

	def t_added_feedback
		t = Teacher.where(:email => session[:teacher]).first.id
		if Feedback.find_by(:teacher_id=>t).nil?
			feedback = Feedback.new
			feedback.ui = params[:rating]
			feedback.simplicity = params[:rating1]
			feedback.performance = params[:rating2]
			feedback.content_quality = params[:rating3]
			feedback.background = params[:rating4]
			feedback.navigation = params[:rating5]
			feedback.links = params[:rating6]
			feedback.color_choices = params[:rating7]
			feedback.graphics = params[:rating8]
			feedback.spelling_and_grammar = params[:rating9]
			feedback.teacher_id = t
			a = Float(params[:rating])+Float(params[:rating1])+Float(params[:rating2])+Float(params[:rating3])+Float(params[:rating4])+Float(params[:rating5])+Float(params[:rating6])+Float(params[:rating7])+Float(params[:rating8])+Float(params[:rating9])
	 		b = a.fdiv 10
	 		feedback.average = b
			feedback.save
			flash[:notice1]="Thankyou for your Feedback.....!!!!"
			redirect_to :back, :layout => "teachers_layout"
		else
				y = Feedback.find_by(:teacher_id=>t).id
				Feedback.find(y).update(:ui => params[:rating])
				Feedback.find(y).update(:simplicity => params[:rating1])
				Feedback.find(y).update(:performance => params[:rating2])
				Feedback.find(y).update(:content_quality => params[:rating3])
				Feedback.find(y).update(:background => params[:rating4])
				Feedback.find(y).update(:navigation => params[:rating5])
				Feedback.find(y).update(:links => params[:rating6])
				Feedback.find(y).update(:color_choices => params[:rating7])
				Feedback.find(y).update(:graphics => params[:rating8])
				Feedback.find(y).update(:spelling_and_grammar => params[:rating9])
				a = Float(params[:rating])+Float(params[:rating1])+Float(params[:rating2])+Float(params[:rating3])+Float(params[:rating4])+Float(params[:rating5])+Float(params[:rating6])+Float(params[:rating7])+Float(params[:rating8])+Float(params[:rating9])
	 			b = a.fdiv 10
				Feedback.find(y).update(:average => b)
				flash[:notice1]="Feedback Updated.....!!!!"
				redirect_to :back, :layout => "teachers_layout"
		end
	end

	#method for badge_count....
	def document_count
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
	 	@noti_count = Notification.count
	 	@my_noti_count=0
	 	if !Notification.where(:teacher_id=>t1).blank?
	 		@my_noti_count = Notification.where(:teacher_id=>t1).count
	 	else
	 		@my_noti_count = 0
	 	end
 	end

 	def download_link
 		render "teachers/download_file"
 	end

end
