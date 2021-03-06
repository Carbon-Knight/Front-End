Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  get 'auth/google_oauth2/callback', to: 'sessions#create'
  get '/dashboard', to: 'dashboard#show'

  get '/log_out', to: 'sessions#destroy'

  resources :cars, only: %i[new create]

  get '/carbon_calculator', to: 'footprints#new'
  post '/carbon_calculator', to: 'footprints#create'

  resources :footprints, only: %i[index edit update]
  resources :resources, only: [:index]
end
