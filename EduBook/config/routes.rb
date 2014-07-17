EduBook::Application.routes.draw do

get '/' => "teachers#welcome"

#_________________________________________________________________
# 										Teacher Side....
#_________________________________________________________________

get '/signup' => "teachers#signup_form"

post '/signup' => "teachers#signup"

get '/login' => "teachers#login_form", :as => 'login_page'

post '/login' => "teachers#login"

get '/profile' => "teachers#profile", :as => 'profile'

get '/upload_file' => "teachers#upload_file", as: 'upload'

post '/upload_file' => "teachers#file_uploaded"

get '/logout' => "teachers#logout"

get '/course' => "teachers#add_course", :as => 'add_course'

post '/course' => "teachers#course_added"

get '/uploads' => "teachers#uploads"

post '/remove_file' => "teachers#remove_file"

get '/overall_uploads' => "teachers#overall_uploads"

post "/overall_uploads" => "teachers#overall_post"

get '/my_courses' => "teachers#my_courses"

get '/notification' => "teachers#add_notification" ,:as => 'notification'

post '/notification' => "teachers#notification_added"

get '/my_notifications' => "teachers#my_notifications"

get '/overall_notifications' => "teachers#overall_notifications"

post '/remove_notification' => "teachers#remove_notification"

get '/change_password' => "teachers#password", :as => 'change_password'

post '/change_password' =>"teachers#change_password"

get '/t_feedback' => "teachers#t_add_feedback"

post '/t_feedback' => "teachers#t_added_feedback"

#_________________________________________________________________
# 										Student Side....
#_________________________________________________________________

get '/student_signup' => "students#signup_form"

post '/student_signup' => "students#signup"

get '/student_login' => "students#login_form", :as => 'student_login_page'

post '/student_login' => "students#login"

get '/student_profile' => "students#profile"

get '/total_uploads' => "students#total_uploads"

post '/total_uploads' =>"students#update_counter"

get '/student_logout' => "students#student_logout"

get '/s_change_password' => "students#s_change_password", :as => 's_change_password'

post '/s_change_password' =>"students#s_changed_password"

get '/s_overall_notification' => "students#s_overall_notification"

get '/s_feedback' => "students#s_add_feedback"

post '/s_feedback' => "students#s_added_feedback"

get '/download_file' => "teachers#download_link"

end
