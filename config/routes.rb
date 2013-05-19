Conquer::Application.routes.draw do

  devise_for :users, path: '', path_names: {sign_in: 'login', sign_out: 'logout'}

  #devise_scope :user do
    #get "enrollment/:id", :to => "enrollments#show", :as => :enrollments
    #get "enrollments/new", :to => "enrollments#new", :as => :new_enrollment
    #post "enrollments", :to => "enrollments#create", :as => :enrollments
  #end

  resources :courses, only: [:index, :show]
  #resources :enrollments

  get '/enroll/:course_id' => 'enrolled_courses#new', as: :new_enrollment
  post '/enroll' => 'enrolled_courses#create'
  get '/my_courses/:course_id' => 'enrolled_courses#show', as: :user_course
  get '/my_courses' => 'enrolled_courses#index', as: :user_root

  get '/about' => 'home#about'  
  get '/contact' => 'home#contact'  
  get '/how' => 'home#how'

  root to: 'home#index'
end
