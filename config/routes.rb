Rails.application.routes.draw do
  root 'sessions#new'

  get  'sessions/new', to: 'sessions#new'
  post 'sessions',     to: 'sessions#create'
  get  'sessions/destroy', to: 'sessions#destroy'

  resources :users

  resources :apis do
    member do
      get :detail
    end
  end

  Api.all.each do |api|
    match "#{api.url}", to: 'apis#show', via: [ api.method.intern ]
  end
end
