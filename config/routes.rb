Rails.application.routes.draw do
  root to: "services#index"
  
  resources :services
end
