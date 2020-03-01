Rails.application.routes.draw do
  
  
  # top
  
  root 'pages#index'
  
  # 新規登録
  resources :users
  
  
  # ログイン,ログアウト
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  # 新規投稿,一覧,詳細,
  resources :recipes do
    resource :comments
  end
  
  # お気に入り
  get 'favorites/index'
  post '/favorites', to: 'favorites#create'
  delete 'cancel', to: 'favorites#cancel'
  
  
  
  # 検索
  
  
end
