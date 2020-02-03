class UsersController < ApplicationController
  
  
  def new
    @User=User.new
  end
  
  def create
    @user=User.new(user_params)
    if @user.save
      redirect_to recipes_index success: "登録に成功しました"
    else
      flash.now[:danger]="登録に失敗しました"
      render :new
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation,:user_image)
  end
end
