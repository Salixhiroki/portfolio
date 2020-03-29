# frozen_string_literal: true

class CommentsController < ApplicationController
  protect_from_forgery except: :create

  # コメントを作成
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.recipe_id = params[:recipe_id]

    @comment.content = comment_params[:content]
    # binding pry
    # 保存
    if @comment.save
      redirect_to "/recipes/#{params[:recipe_id]}", success: 'コメントしました'
    else
      flash.now[:danger] = 'コメントに失敗しました'
      render "/recipes/#{params[:recipe_id]}"
    end
  end

  # コメントの削除
  def destroy
    @comment = Comment.find_by(user_id: current_user.id, recipe_id: params[:recipe_id])
    @comment&.destroy
    # binding pry
    redirect_to "/recipes/#{params[:recipe_id]}", success: 'コメントを削除しました'
  end

  # Strong Parameter
  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
