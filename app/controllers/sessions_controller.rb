class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "You have logged in"
      redirect_to campaign_path user.campaigns.first
    else 
      flash[:alert] = "Invalid email/password"
      render :new
    end
  end
end
