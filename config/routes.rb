Rails.application.routes.draw do
  default_url_options :host => ENV[ 'HOST' ]

  root 'home#index'
  get '/about', to: 'home#about'
  get '/finding-help', to: 'home#finding_help'
  get '/privacy', to: 'home#privacy'

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
    get '/guide', to: 'dashboard#guide'
    resources :reports, only: [:index, :update, :edit, :destroy]
    resources :pledges, only: [:index]
    resources :publications, except: [:show]
  end
end
