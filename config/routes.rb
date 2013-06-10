Conquer::Application.routes.draw do

  devise_for :users, path: '', path_names: {sign_in: 'login', sign_out: 'logout'}

  #devise_scope :user do
    #get "enrollment/:id", :to => "enrollments#show", :as => :enrollments
    #get "enrollments/new", :to => "enrollments#new", :as => :new_enrollment
    #post "enrollments", :to => "enrollments#create", :as => :enrollments
  #end

  resources :ratings, only: [:show, :create]

  get '/promo/:code' => 'promotions#show', as: :promotion

  get '/enroll/:course_id' => 'enrollments#new', as: :new_enrollment
  post '/enroll/:course_id' => 'enrollments#create', as: :enrollments
  get '/enrolled/:id' => 'enrollments#show', as: :enrollment

  get '/my_courses/:id' => 'user_courses#show', as: :user_course
  get '/my_courses' => 'user_courses#index', as: :user_root

  #get '/preorder/:id/new' => 'preorders#new', as: :new_preorder
  #post '/preorders' => 'preorders#create'
  #get '/preorder/:id' => 'preorders#show', as: :preorder

  get '/about' => 'home#about'
  get '/contact' => 'home#contact'
  get '/how' => 'home#how'

  get '/courses' => 'courses#index', as: :courses
  get '/:id' => 'courses#show', as: :course

  root to: 'home#index'
end
