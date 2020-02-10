class RecipesController < ApplicationController
  
  # 新規投稿
  def new
    @recipe=Recipe.new
  end
  
  # 新規作成
  def create
    # binding pry
    @recipe=Recipes.new(recipe_params)
    
    if @recipe.save
      redirect_to recipes_index_path success:"レシピを投稿しました！"
    else
      flash.now[:danger]="レシピの投稿に失敗しました"
      render :new
    end      
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
  
  
  private
  def recipe_params
    params.require(:recipe).permit(:title, :material_name, :material_quantity, :recipe, :point, :image, :impression)
  end
  
  
end
