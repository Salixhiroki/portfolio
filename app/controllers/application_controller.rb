class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?
  
  add_flash_types :success, :info, :warning, :danger


  def current_user
    @current_user ||=User.find_by(id: sesssion[:user_id])
  end
  
  def logged_in?
    !current_user.nil?
  end
  
end
