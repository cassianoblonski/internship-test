require 'rails_helper'

RSpec.describe CheaperRouteController, type: :controller do
  let!(:map_info){
    create(:map, name: "Test_Map", point_connections: {A:{B:10, C:20}, B:{D:15, E:50}, C:{D:30}, D:{E:30}})
  }

  let(:valid_attributes) {
    {map_name: "Test_Map", initial_point: "A", destination: "D", cost: 10}
  }

  let(:invalid_map) {
    {map_name: "Wrong_Name", initial_point: "A", destination: "D", cost: 10}
  }

  let(:invalid_point) {
    {map_name: "Test_Map", initial_point: "A", destination: "Z", cost: 10}
  }

  describe "GET #find_cheaper_route" do
    it "returns a success response" do
      get :find_cheaper_route, params: valid_attributes
      expect(response).to have_http_status(:ok)
    end

    it "returns correct body response" do
      get :find_cheaper_route, params: valid_attributes
      expect(response.body).to eq({
                                  "Map Name": "Test_Map",
                                  "Route Path": "ABD",
                                  "Distance": 25,
                                  "Cost": 250.0
                                  }.to_json)
    end

    it "returns not found response" do
      get :find_cheaper_route, params: invalid_map
      expect(response).to have_http_status(:not_found)
    end

    it "returns error map no found" do
      get :find_cheaper_route, params: invalid_map
      expect(response.body).to eq({
                                  "title":"Map not found",
                                  "detail":"You must provide a valid map name in order to find the cheaper route."
                                  }.to_json)
    end

    it "returns unprocessable entity response" do
      get :find_cheaper_route, params: invalid_point
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "returns error point invalid" do
      get :find_cheaper_route, params: invalid_point
      expect(response.body).to eq({
                                  "title":"One point is not valid",
                                  "detail":"You must provide both valid points (points are case sensitive)."
                                  }.to_json)
    end
  end
end


