Conquer::Application.routes.draw do

  devise_for :users, path: '', path_names: {sign_in: 'login', sign_out: 'logout'}

  resources :courses, only: [:index, :show]
  resources :enrollments, only: [:new, :create, :show]

  get 'about' => 'home#about'  
  get 'contact' => 'home#contact'  
  get 'how' => 'home#how'  

  root to: 'home#index'
end
