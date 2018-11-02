class DonationsRelayJob < ApplicationJob
  queue_as :default

  def perform(donation)
    DonationsChannel.broadcast_to(
      donation.campaign,
      donation: DonationsController.render(partial: 'donations/donation', locals: { donation: donation }),
      raised: donation.campaign.raised
    )
  end
end
