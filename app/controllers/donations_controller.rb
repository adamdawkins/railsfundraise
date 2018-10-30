class DonationsController < ApplicationController
  def create
    @campaign = Campaign.friendly.find(params[:campaign_id])
    @campaign.donations.create(donation_params)

    redirect_to @campaign
  end

  private
    def donation_params
      params.require(:donation).permit(:amount, :name, :is_anonymous, :comment)
    end
end
