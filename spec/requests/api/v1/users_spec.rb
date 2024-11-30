require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  describe "POST /api/v1/users" do
    let(:valid_attributes) { { user: { email: "test@example.com", password: "password" } } }
    let(:invalid_attributes) { { user: { email: "", password: "" } } }

    context "with valid parameters" do
      it "creates a new User" do
        expect {
          post api_v1_users_path, params: valid_attributes
        }.to change(User, :count).by(1)
      end

      it "returns a created status" do
        post api_v1_users_path, params: valid_attributes
        expect(response).to have_http_status(:created)
      end

      it "returns a token" do
        post api_v1_users_path, params: valid_attributes
        json_response = JSON.parse(response.body)
        expect(json_response).to have_key("token")
      end
    end

    context "with invalid parameters" do
      it "does not create a new User" do
        expect {
          post api_v1_users_path, params: invalid_attributes
        }.to change(User, :count).by(0)
      end

      it "returns an unprocessable entity status" do
        post api_v1_users_path, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
