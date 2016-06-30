Rails.application.routes.draw do
  get '/reports/sent', to: 'reports#sent', as: :report_sent
  resources :pledges, only: [:create, :new] do
    collection do
      get 'thankyou'
    end
  end

  resources :reports, only: [:create, :new] do
    collection do
      get 'timeline'
    end
  end

  root 'home#index'
  get '/about', to: 'home#about'

  namespace :admin do
    resources :reports
  end
end
