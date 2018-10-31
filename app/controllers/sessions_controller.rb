class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])

    if is_authenticated(user)
      session[:user_id] = user.id
      flash[:notice] = "You have logged in"
      redirect_to campaign_path user.campaigns.first
    else
      flash[:alert] = "Invalid email/password"
      render :new
    end
  end

  private
    def is_authenticated(user)
      user && user.authenticate(params[:password])
    end
end
