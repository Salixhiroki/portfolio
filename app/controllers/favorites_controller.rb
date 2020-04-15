# frozen_string_literal: true

class FavoritesController < ApplicationController
  # ユーザーのお気に入りのレシピを取得
  def index
    @favorite_recipes = current_user.favorite_topics
  end

  # お気に入りの登録
  def create
    @detail = Recipe.find(params[:recipe_id])
    @favorite = Favorite.new
    @favorite.user_id = current_user.id
    @favorite.recipe_id = params[:recipe_id]
    # binding pry
    logger.debug(request.url)
    if @favorite.save
      # redirect_to recipe_path(@favorite.recipe_id), success: 'お気に入りに登録しました'
      # flash.now[:success] = 'お気に入りに登録しました'
    else
      # flash.now[:danger] = 'お気に入りの登録に失敗しました'
    end
  end

  # お気に入りの解除
  def cancel
    @detail = Recipe.find(params[:recipe_id])
    @favorite = Favorite.find_by(user_id: current_user.id, recipe_id: params[:recipe_id])
    # binding pry
    @favorite&.destroy
  #   redirect_to recipe_path(@favorite.recipe_id), success: 'お気に入りを解除しました'
  end
end
