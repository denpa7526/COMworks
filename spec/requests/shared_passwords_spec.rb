require 'rails_helper'

RSpec.describe "SharedPasswords", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/shared_passwords/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/shared_passwords/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
