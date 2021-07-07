Rails.application.routes.draw do

  root 'pages#home'

  get '/about', to: 'pages#about'

  get 'user/register', to: 'registers#new'
  post 'user/register', to: 'registers#create'

  get 'user/login', to: 'sessions#new'
  post 'user/login', to: 'sessions#create'
  delete 'user/logout', to: 'sessions#destroy'
  # resources :sessions
  resources :profiles
  resources :tasks do
    patch '/status', to: 'tasks#status'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users

  namespace :api do
    namespace :v1 do
      post '/auth/login', to: 'authentication#login'

      resources :users do
        resources :tasks
      end
      
    end
  end

end
