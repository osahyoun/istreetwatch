Rails.application.routes.draw do
  resources :reports
  root 'home#index'
  get '/about', to: 'home#about'
end
