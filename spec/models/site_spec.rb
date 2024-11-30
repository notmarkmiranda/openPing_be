require 'rails_helper'

RSpec.describe Site, type: :model do
  let(:user) { create(:user) } # Assuming you have a user factory

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
  end
end
