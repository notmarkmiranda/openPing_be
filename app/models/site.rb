class Site < ApplicationRecord
  belongs_to :user

  validates :url, presence: true
  validates :frequency, presence: true
end
