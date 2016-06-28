Rails.application.routes.draw do
  get '/reports/sent', to: 'reports#sent', as: :report_sent
  resources :reports do
    collection do
      get 'timeline'
    end
  end
  root 'home#index'
  get '/about', to: 'home#about'
end
