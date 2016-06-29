Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get '/reports/sent', to: 'reports#sent', as: :report_sent
  resources :reports do
    collection do
      get 'timeline'
    end
  end

  get '/pledges/sent', to: 'pledges#sent', as: :pledge_sent
  resources :pledges
 

  root 'home#index'
  get '/about', to: 'home#about'

  namespace :admin do
    resources :reports
  end
end
