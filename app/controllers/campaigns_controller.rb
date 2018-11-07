class CampaignsController < ApplicationController
  before_action :set_campaign, only: [:show, :edit, :update]
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
      @campaign = Campaign.friendly.find(params[:id])
    end

    def campaign_params
      params.require(:campaign).permit(:title, :target, :target_date, :description)
    end
end
