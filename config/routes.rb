Rails.application.routes.draw do
  root 'apis#index'

  resources :sessions

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
