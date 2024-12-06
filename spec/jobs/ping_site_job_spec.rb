require 'rails_helper'

RSpec.describe PingSiteJob, type: :job do
  let(:site) { create(:site, url: "http://example.com", frequency: 10, is_success: true) }

  before do
    allow(HTTParty).to receive(:get).and_return(double(code: 200))
  end

  it "updates the site with the last pinged time and success status" do
    site.update_columns(is_success: false)

    expect {
      described_class.perform_now(site.id)
    }.to change { site.reload.last_pinged_at }
      .and change { site.reload.is_success }.from(false).to(true)
  end

  it "logs an error and sets is_success to false if an exception occurs" do
    allow(HTTParty).to receive(:get).and_raise(StandardError.new("Network error"))

    expect(Rails.logger).to receive(:error).with(/Failed to ping site/)
    expect {
      described_class.perform_now(site.id)
    }.to change { site.reload.is_success }.from(true).to(false)
  end

  it "schedules the next job based on the site's frequency" do
    expect {
      described_class.perform_now(site.id)
    }.to have_enqueued_job(PingSiteJob).with(site.id).at(be_within(1.second).of(site.frequency.seconds.from_now))
  end

  it "stops scheduling after 3 consecutive failures" do
    allow(HTTParty).to receive(:get).and_raise(StandardError.new("Network error"))

    3.times do
      described_class.perform_now(site.id)
    end

    expect {
      described_class.perform_now(site.id)
    }.not_to have_enqueued_job(PingSiteJob)
  end
end
