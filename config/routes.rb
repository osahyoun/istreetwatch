Rails.application.routes.draw do
  root 'home#index'
  get '/about', to: 'home#about'
  get '/finding-help', to: 'home#finding_help'
  get '/reports/sent', to: 'reports#sent', as: :report_sent
  get 'take_the_pledge', to: 'pledges#new', as: :take_the_pledge
  default_url_options :host => ENV[ 'HOST' ]

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

  namespace :admin do
    get '', to: 'dashboard#index', as: :dashboard
    resources :reports, only: [:index, :update, :edit, :destroy]
  end
end
