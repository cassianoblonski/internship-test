require 'rails_helper'

RSpec.describe MapController, type: :controller do
  let(:valid_attributes) {
    { name: "Halan Map", point_connections: {A:{B:10, C:20}, B:{D:15, E:50}, C:{D:30}, D:{E:30}} }
  }

  let(:invalid_attributes) {
    {
      name: nil,
      point_connections: { A:{B:10, C:20}, B:{D:15, E:50}, C:{D:30}, D:{E:30} }
    }
  }

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Map" do
        expect {
          post :create, params: {map: valid_attributes}
        }.to change(Map, :count).by(1)
      end

      it "returns a bad_request response" do
        post :create, params: { map: valid_attributes }
        expect(response).to have_http_status(201)
      end

      it 'returns successfull body response' do
        post :create, params: {map: valid_attributes}
        expect(response.body).to  include("name")&
                                  include("Halan Map")&
                                  include("point_connections")&
                                  include("created_at")&
                                  include("updated_at")
      end
    end

    context "with invalid params" do
      it "returns a bad_request response" do
        post :create, params: {map: invalid_attributes}
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns body response describing error' do
        post :create, params: {map: invalid_attributes}
        expect(response.body).to eq({"name":["can't be blank"]}.to_json)
      end
    end
  end
end
