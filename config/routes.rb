Conquer::Application.routes.draw do

  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout' }, controllers: { confirmations: 'confirmations' }

  devise_scope :user do
    put '/confirm' => 'confirmations#confirm'
  end

  resources :ratings, only: [:show, :create]

  get '/promo/:code' => 'promotions#show', as: :promotion

  get '/enroll/:course_id' => 'enrollments#new', as: :new_enrollment
  post '/enroll/:course_id' => 'enrollments#create', as: :enrollments
  get '/enrolled/:id' => 'enrollments#show', as: :enrollment

  get '/my_courses/:id' => 'user_courses#show', as: :user_course
  get '/my_courses' => 'user_courses#index', as: :user_root

  scope 'my_courses' do
    scope ':course_id' do
      resources :forums do
        resources :topics, controller: 'forum_topics'
      end
    end
  end

  resources :forum_posts
  resources :forum_images

  namespace :admin do
    get '/' => 'courses#index', as: :root
    resources :courses do
      resources :chapters
      resources :promotions
      resources :forums
    end
    resources :users
  end

  get '/about' => 'home#about'
  get '/contact' => 'home#contact'
  get '/how' => 'home#how'

  get '/courses' => 'courses#index', as: :courses
  get '/:id' => 'courses#show', as: :course

  root to: 'home#index'
end
