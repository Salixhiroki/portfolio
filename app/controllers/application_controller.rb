# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :comment_user
  
  before_action :current_user

  add_flash_types :success, :info, :warning, :danger
  # before_action :current_user
  # ユーザーがいればそのユーザーの情報を格納し、いなければユーザーを探す
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # ユーザーが存在するか確認
  def logged_in?
    !current_user.nil?
  end
  
  # ログインしていない場合
  def authenticate_user
    if @current_user == nil
      redirect_to login_path, danger: 'ログインが必要です'
    end
  end
end
