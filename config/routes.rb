Conquer::Application.routes.draw do

  devise_for :users, path: '', path_names: {sign_in: 'login', sign_out: 'logout'}

  #devise_scope :user do
    #get "enrollment/:id", :to => "enrollments#show", :as => :enrollments
    #get "enrollments/new", :to => "enrollments#new", :as => :new_enrollment
    #post "enrollments", :to => "enrollments#create", :as => :enrollments
  #end

  resources :courses, only: [:index, :show]
  #resources :enrollments

  get '/enroll/:course_id' => 'enrollments#new', as: :new_enrollment
  post '/enroll' => 'enrollments#create'
  get '/enrolled/:id' => 'enrollments#show', as: :enrollment

  get '/my_courses/:id' => 'user_courses#show', as: :user_course
  get '/my_courses' => 'user_courses#index', as: :user_root

  #resources :preorders
  get '/preorder/:id/new' => 'preorders#new', as: :new_preorder
  post '/preorders' => 'preorders#create'
  get '/preorder/:id' => 'preorders#show', as: :preorder

  get '/about' => 'home#about'  
  get '/contact' => 'home#contact'  
  get '/how' => 'home#how'

  root to: 'home#index'
end
