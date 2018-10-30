class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      campaign = @user.campaigns.build({ title: "#{@user.first_name}'s Run For Freedom" })
      campaign.save
      redirect_to campaign
    else 
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:full_name, :email, :password)
  end
end
