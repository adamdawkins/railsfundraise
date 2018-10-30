class UsersController < ApplicationController
  def new
    @user = User.new
    @campaign_type = params[:campaign_type]
  end

  def create
    @user = User.new(user_params)

    if @user.save
      campaign = Campaign.new_landing_campaign(params[:campaign_type], @user)
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
