require 'rails_helper'

RSpec.describe "HeyController", type: :request do
  describe "GET /" do
    it "returns a teapot message" do
      get root_path
      expect(response).to have_http_status(418)
      json_response = JSON.parse(response.body)
      expect(json_response["message"]).to eq("I'm a teapot")
    end
  end
end
