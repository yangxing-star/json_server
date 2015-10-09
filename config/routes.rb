Rails.application.routes.draw do
  root 'sessions#new'

  get  'sessions/new', to: 'sessions#new'
  post 'sessions',     to: 'sessions#create'
  get  'sessions/destroy', to: 'sessions#destroy'

  resources :users

  resource :profiles do
    member do
      get :change_locale
    end
  end

  resources :apis do
    member do
      get :detail
    end
  end

  Api.all.each do |api|
    match "#{api.url}", to: 'apis#show', via: [ api.method.try(:intern) ]
  end
end
