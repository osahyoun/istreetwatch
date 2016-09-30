Rails.application.routes.draw do
  get '/reports/sent', to: 'reports#sent', as: :report_sent
  get 'take_the_pledge', to: 'pledges#new', as: :take_the_pledge

  resources :pledges, only: [:create, :new] do
    collection do
      get 'thankyou'
    end
  end

  resources :reports, only: [:create, :show, :new] do
    collection do
      get 'timeline'
      get 'search'
    end
  end

  root 'home#index'
  get '/about', to: 'home#about'
  get '/support', to: 'home#support'

  namespace :admin do
    resources :reports
  end
end
