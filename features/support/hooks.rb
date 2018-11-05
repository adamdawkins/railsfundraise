Before do
  puts "Skipping campaign.send_to_mailchimp callback"
  Campaign.skip_callback(:create, :after, :send_to_mailchimp)
end

After do
  Campaign.set_callback(:create, :after, :send_to_mailchimp)
end
