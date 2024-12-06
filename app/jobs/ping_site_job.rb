class PingSiteJob < ApplicationJob
  queue_as :default

  def perform(site_id)
    site = Site.find(site_id)
    response = ping_site(site)

    if response_successful?(response)
      handle_success(site)
    else
      handle_failure(site)
    end

    log_response(site, response)
    schedule_next_job(site, site_id)
  rescue StandardError => e
    handle_exception(site, e, site_id)
  end

  private

  def ping_site(site)
    HTTParty.get(site.url)
  end

  def response_successful?(response)
    response.code.between?(200, 299)
  end

  def handle_success(site)
    site.update_columns(last_pinged_at: Time.current, is_success: true, consecutive_failures: 0)
  end

  def handle_failure(site)
    site.increment!(:consecutive_failures)
    site.update_columns(is_success: false)
  end

  def log_response(site, response)
    Rails.logger.info("Pinged site #{site.url} with response code #{response.code}")
  end

  def schedule_next_job(site, site_id)
    if site.consecutive_failures < 3 && site.is_active
      PingSiteJob.set(wait: site.frequency.seconds).perform_later(site_id)
    end
  end

  def handle_exception(site, exception, site_id)
    Rails.logger.error("Failed to ping site #{site.url}: #{exception.message}")
    handle_failure(site)
    schedule_next_job(site, site_id)
  end
end
