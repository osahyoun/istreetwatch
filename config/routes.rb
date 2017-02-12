Rails.application.routes.draw do
  default_url_options :host => ENV[ 'HOST' ]

  root 'home#index'
  get '/about', to: 'home#about'
  get '/finding-help', to: 'home#finding_help'

  resources :pledges, only: [:create, :new] do
    collection do
      get 'thankyou'
    end
  end

  resources :reports, only: [:create, :show, :new] do
    collection do
      get 'timeline'
    end
  end
  get '/reports', to: redirect( '/reports/timeline' )
  get '/reports/sent', to: 'reports#sent', as: :report_sent

  namespace :admin do
    get '', to: 'dashboard#index', as: :dashboard
    resources :reports, only: [:index, :update, :edit, :destroy]
  end
end
