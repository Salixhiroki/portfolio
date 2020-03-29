# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :comment_user

  add_flash_types :success, :info, :warning, :danger

  # ユーザーがいればそのユーザーの情報を格納し、いなければユーザーを探す
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # ユーザーが存在するか確認
  def logged_in?
    !current_user.nil?
  end
end
