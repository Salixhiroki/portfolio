class RecipesController < ApplicationController
  
  # 新規投稿
  def new
    # @recipe=Recipe.new
  end
  
  # 新規作成
  def create
    
  end
  
  
  # 投稿一覧
  def index
    # @recipes=Recipes.all.order(created_at: :desc)
  end
  
  
  # 投稿詳細
  def show
    # @detail=Recipe.find_by(id: params[:id])
    # @user=User.find_by(id: @detail.user_id)
  end
  
  
  
end
