Rails.application.routes.draw do
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

  root 'home#index'
  get '/about', to: 'home#about'

  namespace :admin do
    resources :reports
  end
end
