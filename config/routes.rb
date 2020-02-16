Rails.application.routes.draw do
  
  
  # top
  
  root 'pages#index'
  
  # 新規登録
  
  
  # root 'users#new'
  resources :users
  
  
  # ログイン
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  # 一覧
  
  get 'recipes/index', to: 'recipes#index'
  
  
  # 詳細
  
  get 'recipes/show', to: 'recipes#show'
  
  
  # 検索
  
  
  
  # 新規投稿
  post 'recipes/create', to: 'recipes#create'
  resources :recipes
  

end
