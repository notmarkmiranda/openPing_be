require 'rails_helper'

RSpec.describe "Api::V1::Sessions", type: :request do
  describe "POST /api/v1/sessions" do
    let(:user) { create(:user, email: "test@example.com", password: "password") }

    context "with valid credentials" do
      it "returns a token" do
        post api_v1_sessions_path, params: { email: user.email, password: "password" }
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response).to have_key("token")
      end
    end

    context "with invalid credentials" do
      it "returns an unauthorized status" do
        post api_v1_sessions_path, params: { email: user.email, password: "wrong_password" }
        expect(response).to have_http_status(:unauthorized)
        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to eq("Invalid email or password")
      end
    end
  end
end
