Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'days#show'

  resources :days, only: [:index, :create]

  get 'about', to: 'pages#about', as: :about
  get ':date', to: 'days#show', as: :day
end
