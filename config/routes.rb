Rails.application.routes.draw do
  root to: "services#index"
  
  resources :services
  resources :slack, only: :create
end
