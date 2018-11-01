class DonationsChannel < ApplicationCable::Channel
  def subscribed
    campaign = Campaign.friendly.find(params[:slug])
    stream_for campaign
  end

  def unsubscribed
    stop_all_streams
  end
end
