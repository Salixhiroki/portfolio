Rails.application.routes.draw do
  # root 'recipes#index'
  root 'recipes#new'
  
  get 'recipes/show', to: 'recipes#show'
  
  resources :recipes
  
end
