Rails.application.routes.draw do
  # root 'recipes#index'
  root 'recipes#show'
  
  resources :recipes
  
end
