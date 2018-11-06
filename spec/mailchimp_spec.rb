require_relative "../lib/mailchimp"
require "webmock/rspec"

describe Mailchimp do
  describe "Mailchimp.update_member" do
    let (:email) { "adam@dragondrop.uk" }
    let (:merge_fields) { { FNAME: "Adam", LNAME: "Dawkins"  } }
    let (:api_key) { "233b5f56c49ca1007acbcoeuourcg3f8-us17" }
    let (:list_id) { "a_list_id" }
    let (:list_url) { "https://us17.api.mailchimp.com/3.0/lists/#{list_id}" }
    let (:member_update_url) { "#{list_url}/members/#{Digest::MD5.hexdigest(email)}" }

    before do
      stub_request(:put, member_update_url)
      Mailchimp.update_member(email, api_key, list_id, merge_fields)
    end

    it "PUTS to /lists/list_id/members with the subscriber_hash" do
      expect(
        a_request(:put, member_update_url)
      ).to have_been_made
    end

    it "sets status and status if new to subscribed" do
      expect(
        a_request(:put, member_update_url)
        .with(body: hash_including(
          status: "subscribed",
          status_if_new: "subscribed"
      ))
      ).to have_been_made
    end
    it "sends the email address as email_address" do
      expect(
        a_request(:put, member_update_url)
        .with(body: hash_including(
          email_address: email
      ))
      ).to have_been_made
    end

    it "passes the merge_fields through to mailchimp" do
      expect(
        a_request(:put, member_update_url)
        .with(body: hash_including(merge_fields: merge_fields))
      ).to have_been_made
    end
  end

  describe "#dc" do
    it "returns the part of a string after the -" do
      expect(Mailchimp.dc("a-b")).to eq "b"
    end
  end
end
