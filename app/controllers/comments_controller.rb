# frozen_string_literal: true

class CommentsController < ApplicationController
  # before_action :all_comments, only: [:create, :destroy]

  protect_from_forgery except: :create
  
  # コメントを作成
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.recipe_id = params[:recipe_id]

    @comment.content = comment_params[:content]
    @comments=Comment.where(recipe_id: params[:recipe_id])
    # binding pry
    # 保存
    if @comment.save
    else
      flash.now[:danger] = 'コメントに失敗しました'
      # render "/recipes/#{params[:recipe_id]}"
    end
  end

  # コメントの削除
  def destroy
    @comment = Comment.find_by(id: params[:id], user_id: current_user.id, recipe_id: params[:recipe_id])
    # binding pry
    
    @comment&.destroy
    @comments=Comment.where(recipe_id: params[:recipe_id])
    # binding pry
    # redirect_to "/recipes/#{params[:recipe_id]}", success: 'コメントを削除しました'
  end

  # Strong Parameter
  private
  
  def comment_params
    params.require(:comment).permit(:content)
  end
  
  # def all_comments
  #   @comments = Comment.all
  # end
  
  
end
