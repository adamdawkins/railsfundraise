require "faraday"

class Mailchimp
  def self.dc(api_key)
    api_key.split('-')[1]
  end

  def self.member_url (api_key, list_id, email)
    subscriber_hash = Digest::MD5.hexdigest(email.downcase)
    "https://#{dc(api_key)}.api.mailchimp.com/3.0/lists/#{list_id}/members/#{subscriber_hash}"
  end

  def self.base_connection(api_key)
    Faraday.new do |conn|
      conn.basic_auth(api_key, api_key)
      conn.adapter Faraday.default_adapter
    end
  end

  def self.member_json(email, merge_fields)
    {
    email_address: email,
      status: "subscribed",
      status_if_new: "subscribed",
      merge_fields: merge_fields
    }.to_json
  end

  def self.update_member(email, api_key, list_id, merge_fields)
    response = base_connection(api_key).put do |req|
      req.url member_url(api_key, list_id, email)
      req.headers['Content-Type'] = 'application/json'
      req.body = member_json(email, merge_fields)
    end

    puts response.body
  end
end
