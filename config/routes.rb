Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  get 'auth/google_oauth2/callback', to: 'sessions#create'
  get '/dashboard', to: 'dashboard#show'

  get '/log_out', to: 'sessions#destroy'

  get '/car_monthly_mileages/new', to: 'car_monthly_mileages#new'
  get '/cars/new', to: 'cars#new'
  post '/cars', to: 'cars#create'

  resources :resources, only: [:index]
end
