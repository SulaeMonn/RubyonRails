Rails.application.routes.draw do
  resources :password_resets
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :posts do
    collection { post :import }
  end
  root 'posts#index'
  post 'post/createConfirm' , to: 'posts#createConfirm'
  patch 'post/editConfirm' , to: 'posts#editConfirm'
  post 'post/update' , to: 'posts#update'
  get '/search' , to: 'posts#search'
  get 'post/upload' , to: 'posts#upload'

  resources :users
  get '/profile' , to: 'users#profile'
  get '/searchuser' , to: 'users#search'

  # get 'sessions/welcome'
  get 'login', to:'sessions#new'
  post 'login', to:'sessions#create'
  delete 'logout', to:'sessions#destroy'

end
