class Site < ApplicationRecord
  belongs_to :user

  validates :url, presence: true, uniqueness: { scope: :user_id }
  validates :frequency, presence: true
  validate :url_must_be_valid

  private

  def url_must_be_valid
    uri = URI.parse(url)
    unless uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
      errors.add(:url, "must be a valid HTTP or HTTPS URL")
    end
  rescue URI::InvalidURIError
    errors.add(:url, "must be a valid URL")
  end
end
