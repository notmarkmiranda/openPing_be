class PingSiteJob < ApplicationJob
  queue_as :default

  def perform(site_id)
    site = Site.find(site_id)
    response = HTTParty.get(site.url)

    success = response.code.between?(200, 299)
    site.update_columns(last_pinged_at: Time.current, is_success: success)
  rescue StandardError => e
    Rails.logger.error("Failed to ping site #{site.url}: #{e.message}")
    site.update_columns(is_success: false)
  end
end
