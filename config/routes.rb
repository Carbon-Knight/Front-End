Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  get 'auth/google_oauth2/callback', to: 'sessions#create'
  get '/dashboard', to: 'dashboard#show'

  get '/car_monthly_mileages/new', to: 'car_monthly_mileages#new'
  get '/cars/new', to: 'car#new'
  post '/cars', to: 'car#create'
end
