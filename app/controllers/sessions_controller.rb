class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    user=User.find_by(email: session_params[:email])
    # binding pry
    if user && user.authenticate(session_params[:password])
      log_in user
      redirect_to recipes_index_path, success: "ログインに成功しました"
      
    else
      flash.now[:danger]="ログインに失敗しました"
      # binding pry
      render :new
      
    end
    
  end   
  
  
  private
  
    def log_in(user)
      session[:user_id]=user.id
    end
      
    
    def session_params
      params.require(:session).permit(:email,:password)
    end
        
  
  
  
end
