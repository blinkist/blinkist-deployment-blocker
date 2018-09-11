Rails.application.routes.draw do
  resources :services
  resources :slack, only: :create
end
