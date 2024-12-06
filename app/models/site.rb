class Site < ApplicationRecord
  belongs_to :user

  validates :url, presence: true, uniqueness: { scope: :user_id }
  validates :frequency, presence: true
  validate :url_must_be_valid

  after_create :enqueue_ping_job
  after_update :enqueue_ping_job, if: :saved_change_to_url?

  private

  def enqueue_ping_job
    PingSiteJob.perform_later(self.id)
  end

  def url_must_be_valid
    uri = URI.parse(url)
    unless uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
      errors.add(:url, "must be a valid HTTP or HTTPS URL")
    end
  rescue URI::InvalidURIError
    errors.add(:url, "must be a valid URL")
  end
end
