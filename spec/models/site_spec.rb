require 'rails_helper'

RSpec.describe Site, type: :model do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }

  describe "Validations" do
    it "is valid with valid attributes" do
      site = Site.new(url: "http://example.com", frequency: 10, user: user)
      expect(site).to be_valid
    end

    it "is not valid without a url" do
      site = Site.new(url: nil, frequency: 10, user: user)
      expect(site).to_not be_valid
    end

    it "is not valid without a frequency" do
      site = Site.new(url: "http://example.com", frequency: nil, user: user)
      expect(site).to_not be_valid
    end

    it "is not valid without a user" do
      site = Site.new(url: "http://example.com", frequency: 10, user: nil)
      expect(site).to_not be_valid
    end

    it "validates uniqueness of url scoped to user_id" do
      create(:site, url: "http://example.com", user: user)
      site2 = build(:site, url: "http://example.com", user: user)

      expect(site2).not_to be_valid
      expect(site2.errors[:url]).to include("has already been taken")

      # Ensure a different user can have the same URL
      site3 = build(:site, url: "http://example.com", user: another_user)
      expect(site3).to be_valid
    end

    it "is not valid with an invalid URL" do
      site = Site.new(url: "invalid-url", frequency: 10, user: user)
      expect(site).to_not be_valid
      expect(site.errors[:url]).to include("must be a valid HTTP or HTTPS URL")
    end

    it "is valid with a valid HTTP URL" do
      site = Site.new(url: "http://valid-url.com", frequency: 10, user: user)
      expect(site).to be_valid
    end

    it "is valid with a valid HTTPS URL" do
      site = Site.new(url: "https://valid-url.com", frequency: 10, user: user)
      expect(site).to be_valid
    end
  end
end
