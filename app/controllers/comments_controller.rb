class CommentsController < ApplicationController

    protect_from_forgery except: :create
    
  
  def create
    # @detail=Recipe.find(params[:id])
    # @detail.comments.create(comment_params)
    # @detail.comments.user_id=
    # redirect_to recipe_path(@detail),success: "コメントしました"
    
    @comment=Comment.new(comment_params)
    @comment.user_id=current_user.id
    @comment.recipe_id=params[:recipe_id]
   
    @comment.content=comment_params[:content]
    # binding pry
    if @comment.save
      redirect_to "/recipes/#{params[:recipe_id]}", success: "コメントしました"
    else
      flash.now[:danger]="コメントに失敗しました"
      render "/recipes/#{params[:recipe_id]}"
    end
  end
  
  
  def destroy
    @comment=Comment.find_by(user_id: current_user.id, recipe_id: params[:recipe_id])
    @comment.destroy
   redirect_to "/recipes/#{params[:recipe_id]}", success: "コメントを削除しました"
  end


  private
  def comment_params
    params.require(:comment).permit(:content)
  end

end
