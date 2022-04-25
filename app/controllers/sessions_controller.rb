class SessionsController < ApplicationController
  def new
  end

  
    def create
      if user = User.authenticate_with_credentials(params[:email], params[:password])
        # success logic, log them in
      else
        # failure, render login form
      end
    
    end

  

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
end