require 'rails_helper'

RSpec.describe "Comments", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/comments/create"
      expect(response).to have_http_status(:success)
    end
  end

end
