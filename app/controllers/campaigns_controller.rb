class CampaignsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :verify_ownership!, only: [:edit, :update]
  before_action :set_campaign, only: [:show]
  def show
  end

  def index
    @campaigns = Campaign.all
  end

  def edit
  end

  def update
    if @campaign.update(campaign_params)
      flash[:notice] = "Campaign updated successfully"
      redirect_to @campaign
    else
      flash[:alert] = "There was a problem updating the campaign"
      render :edit
    end
  end

  private
    def set_campaign
      @campaign ||= Campaign.friendly.find(params[:id])
    end

    def campaign_params
      params.require(:campaign).permit(:title, :target, :target_date, :description)
    end

    def verify_ownership!
      set_campaign
      redirect_to(@campaign) and return unless @campaign.user == current_user
    end
end
