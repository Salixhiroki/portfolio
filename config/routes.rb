Rails.application.routes.draw do
  # root 'recipes#index'
  root 'recipes#index'
  
  get 'recipes/show', to: 'recipes#show'
  
  
  resources :recipes
  
end
