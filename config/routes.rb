Rails.application.routes.draw do
  
  
  # top
  
  root 'pages#index'
  
  # 新規登録
  
  
  # root 'users#new'
  resources :users
  
  
  # ログイン
  
  get 'sessions/new'
  
  
  # 一覧
  
  get 'recipes/index', to: 'recipes#index'
  
  
  # 詳細
  
  get 'recipes/show', to: 'recipes#show'
  
  
  # 検索
  
  
  
  # 新規投稿
  
  resources :recipes
  

end
