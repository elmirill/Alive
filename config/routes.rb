Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'days#show'

  resources :days, only: [:index, :create]
  resources :diary_entries, except: :show
  resources :day_entries, only: [:edit, :update]
  
  get 'edit-diary', to: 'diary_entries#index', as: :edit_diary

  get 'about', to: 'pages#about', as: :about

  get ':date', to: 'days#show', as: :day
end
