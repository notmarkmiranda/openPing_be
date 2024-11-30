require 'rails_helper'
include TokenGenerator

RSpec.describe "Api::V1::Sites", type: :request do
  let(:user) { create(:user) }
  let(:headers) { { "Authorization" => "Bearer #{generate_token(user)}" } }
  let!(:site) { create(:site, user: user) }

  describe "GET /api/v1/sites" do
    before do
      create_list(:site, 3, user: user)
    end

    it "returns a list of sites" do
      get api_v1_sites_path, headers: headers
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response.size).to eq(4)
    end

    it "returns unauthorized without a valid token" do
      get api_v1_sites_path
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "GET /api/v1/sites/:id" do
    it "returns the site" do
      get api_v1_site_path(site), headers: headers
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response["id"]).to eq(site.id)
    end

    it "returns unauthorized without a valid token" do
      get api_v1_site_path(site)
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "POST /api/v1/sites" do
    let(:valid_attributes) { { site: { url: "http://example.com", frequency: 10, is_active: true } } }
    let(:invalid_attributes) { { site: { url: "", frequency: nil } } }

    context "with valid parameters" do
      it "creates a new Site" do
        expect {
          post api_v1_sites_path, params: valid_attributes, headers: headers
        }.to change(Site, :count).by(1)
      end

      it "returns a created status" do
        post api_v1_sites_path, params: valid_attributes, headers: headers
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Site" do
        expect {
          post api_v1_sites_path, params: invalid_attributes, headers: headers
        }.to change(Site, :count).by(0)
      end

      it "returns an unprocessable entity status" do
        post api_v1_sites_path, params: invalid_attributes, headers: headers
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /api/v1/sites/:id" do
    let(:new_attributes) { { site: { url: "http://newexample.com" } } }

    context "with valid parameters" do
      it "updates the requested site" do
        patch api_v1_site_path(site), params: new_attributes, headers: headers
        site.reload
        expect(site.url).to eq("http://newexample.com")
      end

      it "returns a success status" do
        patch api_v1_site_path(site), params: new_attributes, headers: headers
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid parameters" do
      it "returns an unprocessable entity status" do
        patch api_v1_site_path(site), params: { site: { url: "" } }, headers: headers
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /api/v1/sites/:id" do
    it "destroys the requested site" do
      expect {
        delete api_v1_site_path(site), headers: headers
      }.to change(Site, :count).by(-1)
    end

    it "returns a no content status" do
      delete api_v1_site_path(site), headers: headers
      expect(response).to have_http_status(:no_content)
    end
  end
end
