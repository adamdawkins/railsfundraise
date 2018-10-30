class CampaignsController < ApplicationController
  def show
    @campaign = Campaign.friendly.find(params[:id])
  end
end
