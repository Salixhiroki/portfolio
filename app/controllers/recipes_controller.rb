class RecipesController < ApplicationController
  def new
    # @recipe=Recipe.new
  end
  
  def create
    
  end
  
  
  def index
    # @recipes=Recipes.all.order(created_at: :desc)
  end
  
  def show
    # @detail=Recipe.find_by(id: params[:id])
    # @user=User.find_by(id: @detail.user_id)
  end
  
end
