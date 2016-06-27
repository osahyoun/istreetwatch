Rails.application.routes.draw do
  resources :reports
  root 'home#index'
end
