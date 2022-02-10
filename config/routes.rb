Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }

  devise_scope :user do
    unauthenticated do
      root 'users/registrations#new'
    end

    authenticated :user do
      root 'days#show', as: :auth_root
    end

    # Users
    get 'signup', to: 'users/registrations#new', as: :signup
    post 'signup', to: 'users/registrations#create'
    get 'edit-user', to: redirect('/settings')
    patch 'edit-user', to: 'users/registrations#update'
    delete 'delete-account', to: 'users/registrations#destroy', as: :delete_account

    # Auth
    get 'signin', to: 'devise/sessions#new', as: :signin
    # post 'signin', to: 'devise/sessions#create'
    delete 'signout', to: 'devise/sessions#destroy', as: :signout
  end

  # Diary
  resources :days, only: [:index, :create]
  get ':date', to: 'days#show', as: :day, date: /(\d|-){8,10}/
  get 'today', to: 'days#show', as: :today

  resources :diary_entries, except: [:show, :new]
  get 'edit-diary', to: 'diary_entries#index', as: :edit_diary

  resources :day_entries, only: [:update]

  # Pages
  get 'about', to: 'pages#about', as: :about
  get 'settings', to: 'pages#settings', as: :settings
  get 'check-email', to: 'pages#check_email', as: :check_email

end
