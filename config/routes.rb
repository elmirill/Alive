Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Diary
  root 'days#show'

  resources :days, only: [:index, :create]
  get ':date', to: 'days#show', as: :day, date: /(\d|-){8,10}/

  resources :diary_entries, except: [:show, :new]
  get 'edit-diary', to: 'diary_entries#index', as: :edit_diary

  resources :day_entries, only: [:update]
  
  # Users
  get 'signup', to: 'users#new', as: :signup
  post 'signup', to: 'users#create'
  get 'edit-user', to: redirect('/settings')
  patch 'edit-user', to: 'users#update'
  delete 'delete-account', to: 'users#destroy', as: :delete_account

  # Auth
  get 'signin', to: 'sessions#new', as: :signin
  post 'signin', to: 'sessions#create'
  delete 'signout', to: 'sessions#destroy', as: :signout

  # Pages
  get 'about', to: 'pages#about', as: :about
  get 'settings', to: 'pages#settings', as: :settings

end
