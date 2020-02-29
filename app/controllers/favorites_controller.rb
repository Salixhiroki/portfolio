class FavoritesController < ApplicationController


  def index
    @favorite_recipes=current_user.favorite_topics
  end

  def create
    @favorite=Favorite.new
    @favorite.user_id=current_user.id
    @favorite.recipe_id=params[:recipe_id]
    # binding pry
    if @favorite.save
      redirect_to recipes_path, success:"お気に入りに登録しました"
    else
      flash.now[:danger]="お気に入りの登録に失敗しました"
    end
  end
  
  def cancel
    @favorite=Favorite.find_by(user_id: current_user.id,recipe_id: params[:recipe_id])
    @favorite.destroy
    redirect_to recipes_path, success: "お気に入りを解除しました"
  end

end
