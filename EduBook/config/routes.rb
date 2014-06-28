EduBook::Application.routes.draw do

get '/signup' => "teachers#signup_form"

post '/signup' => "teachers#signup"

get '/login' => "teachers#login_form", :as => 'login_page'

post '/login' => "teachers#login"

get '/profile' => "teachers#profile", :as => 'profile'

get '/upload_file' => "teachers#upload_file", as: 'upload'

post '/upload_file' => "teachers#file_uploaded"

post '/logout' => "teachers#logout"

get '/download_file' => "teachers#download_file"

get '/course' => "teachers#add_course", :as => 'add_course'

post '/course' => "teachers#course_added"

get '/uploads' => "teachers#uploads"

post '/remove_file' => "teachers#remove_file"

get '/overall_uploads' => "teachers#overall_uploads"

get '/' => "teachers#welcome"



get '/student_signup' => "students#signup_form"

post '/student_signup' => "students#signup"

get '/student_login' => "students#login_form", :as => 'student_login_page'

post '/student_login' => "students#login"

get '/student_profile' => "students#profile"

get '/total_uploads' => "students#total_uploads"

post '/student_logout' => "students#logout"

end
