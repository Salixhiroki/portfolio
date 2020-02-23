class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    user=User.find_by(email: session_params[:email])
    # binding pry
    if user && user.authenticate(session_params[:password])
      log_in user
      redirect_to recipes_path, success: "ログインに成功しました"
      
    else
      flash.now[:danger]="ログインに失敗しました"
      # binding pry
      render :new
      
    end
    
  end   
  
  
  def destroy
    log_out
    redirect_to root_url, info:"ログアウトしました"
  end

  
  
  
  private
  
    def log_in(user)
      session[:user_id]=user.id
    end
    
    def log_out
      session.delete(:user_id)
      @current_user=nil
    end
    
    
    def session_params
      params.require(:session).permit(:email,:password)
    end
        
  
  
  
end
