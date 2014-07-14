class StudentsController < ApplicationController

	def login_form
		if !session[:student].nil?
			@student = Student.where(:email => session[:student]).first
			upload_count
			render 'students/profile', :layout => "students_layout"
		else
			render 'students/s_login_form'
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
			upload_count
			render 'students/profile', :layout => "students_layout"
		end
	end

	def profile
		@student = Student.where(:email=>session[:student]).first
		if @student.email==session[:student]
			#for badge_count
			upload_count
			render 'students/profile', :layout => "students_layout"
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

	def student_logout
		session[:student] = nil
		render 'students/s_login_form'
	end

	def s_change_password
		student = Student.where(:email => session[:student]).first	
		@pass = student.password
		upload_count
		render 'students/s_change_password', :layout => "students_layout"
	end

	def s_changed_password
		student = Student.where(:email => session[:student]).first	
		Student.find(student.id).update(:password => params[:renter_password])
		upload_count
		flash[:notice]="Password Updated Successfully....!!!!"
		redirect_to :back, :layout => "students_layout"
	end

	def s_overall_notification
		upload_count
		@notification = Notification.order("created_at ASC").joins("INNER JOIN semesters ON semesters.id = notifications.semester").joins("INNER JOIN teachers ON teachers.id = notifications.teacher_id").select("notifications.*, semesters.year as year, semesters.branch as branch,semesters.semester_type as semester_type, teachers.name as teacher_name,teachers.surname as teacher_surname").paginate(:page => params[:page], :per_page => 5)
		render 'students/s_overall_notification', :layout => "students_layout"
	end

	def total_uploads
		@documents = Document.order("created_at ASC").joins("INNER JOIN courses ON courses.id = documents.course_id").joins("INNER JOIN teachers ON teachers.id = courses.teacher_id").select("documents.*,courses.course_name as course_name, teachers.name as teacher_name").paginate(:page => params[:page], :per_page => 6)
		#for badge_count
		upload_count
		render 'students/total_uploads', :layout => "students_layout"
	end

	def s_add_feedback
		upload_count
		render 'students/s_feedback', :layout => "students_layout"
	end

	def s_added_feedback
		s = Student.where(:email => session[:student]).first.id
		if Feedback.find_by(:student_id=>s).nil?
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
			feedback.student_id = s
			a = Float(params[:rating])+Float(params[:rating1])+Float(params[:rating2])+Float(params[:rating3])+Float(params[:rating4])+Float(params[:rating5])+Float(params[:rating6])+Float(params[:rating7])+Float(params[:rating8])+Float(params[:rating9])
	 		b = a.fdiv 10
	 		feedback.average = b
			feedback.save
			upload_count
			flash[:notice1]="Thank You for your Feedback....!!!!"
			redirect_to :back, :layout => "students_layout"
		else
				y = Feedback.find_by(:student_id=>s).id
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
				upload_count
				flash[:notice1]="Feedback Updated....!!!!"
				redirect_to :back, :layout => "students_layout"
		end
	end

	#method for badge_count
	def upload_count
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
 	end

end
