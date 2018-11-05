class DonationsController < ApplicationController
  before_action :set_campaign, only: [:create]
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    donation = @campaign.donations.create!(donation_params)
  end

  private
    def set_campaign
      @campaign = Campaign.friendly.find(params[:campaign_id])
    end

    def donation_params
      params.require(:donation).permit(
        :amount, :first_name, :last_name, :is_anonymous, :comment, :is_gift_aid
      )
    end
end
