require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new(email: "test@example.com", password: "password") }

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without an email" do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a password" do
      subject.password = nil
      expect(subject).to_not be_valid
    end

    it "is not valid with a duplicate email" do
      described_class.create!(email: "test@example.com", password: "password")
      expect(subject).to_not be_valid
    end
  end

  describe "Password encryption" do
    it "encrypts the password" do
      user = described_class.create!(email: "test@example.com", password: "password")
      expect(user.password_digest).to_not eq("password")
    end
  end

  describe "Authentication" do
    it "authenticates with correct password" do
      user = described_class.create!(email: "test@example.com", password: "password")
      expect(user.authenticate("password")).to eq(user)
    end

    it "does not authenticate with incorrect password" do
      user = described_class.create!(email: "test@example.com", password: "password")
      expect(user.authenticate("wrong_password")).to be_falsey
    end
  end
end
