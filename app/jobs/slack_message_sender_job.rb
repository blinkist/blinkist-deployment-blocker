class SlackMessageSenderJob < ApplicationJob
  queue_as :default

  def perform(callback_url, data)
    uri = URI(callback_url)

    conn = Faraday.new(url: callback_url)
    response = conn.post do |req|
      req.url uri.request_uri
      req.headers['Content-Type'] = 'application/json'
      req.body = data
    end

    Rails.logger.info("Send data to #{callback_url} #{response.inspect}")
  end
end
