# frozen_string_literal: true

class SessionsController < ApplicationController
  # アカウントの新規画面へ遷移
  def new
    @login = User.new
  end

  # アカウント新規作成
  def create
    user = User.find_by(email: session_params[:email])
    # binding pry

    if user&.authenticate(session_params[:password])
      log_in user
      redirect_to recipes_path, success: 'ログインに成功しました'
    else
      flash.now[:danger] = 'ログインに失敗しました'
      @error="メールアドレスまたはパスワードが間違っています"
      # binding pry
      render :new
    end
  end

  # ログアウト
  def destroy
    log_out
    redirect_to root_url, info: 'ログアウトしました'
  end

  #  Strong Parameter
  private

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
