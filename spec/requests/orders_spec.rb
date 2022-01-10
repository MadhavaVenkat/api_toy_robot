require 'rails_helper'

RSpec.describe "Orders", type: :request do
  describe "GET /api/robot/0/orders" do
    it "has no order command" do
      get "/api/robot/0/orders"
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response.body).to include("Please place a order")
    end

    it "has output for order" do
      get "/api/robot/0/orders", params: {command: ["PLACE 0,0, EAST", "MOVE", "MOVE", "LEFT", "MOVE", "REPORT"] }
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response.body).to include("Output")
    end

    it "has falling order" do
      get "/api/robot/0/orders", params: {command: ["PLACE 6,0, EAST", "MOVE", "MOVE", "LEFT", "MOVE", "REPORT"] }
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response.body).to include("Robot is about to falling")
    end
  end
end
