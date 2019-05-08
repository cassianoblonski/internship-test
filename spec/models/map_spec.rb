require 'rails_helper'

RSpec.describe Map, type: :model do
  let(:map_info) { create(:map) }

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to validate_presence_of(:point_connections) }
  end

  describe 'factory' do
    it 'set valid map' do
      mapa = Map.new(name: "Halan Map", point_connections: { A:{B:10, C:20}, B:{D:15, E:50}, C:{D:30}, D:{E:30} })
      expect(map_info.point_connections).to eq(mapa.point_connections)
    end
  end

  describe '#find_all_routes' do
    it 'return valid paths from A to B' do
      expect(map_info.find_all_routes(:A,:B)).to eq( {route_path: "AB", distance: 10} )
    end

    it 'return valid paths from A to D' do
      expect(map_info.find_all_routes(:A,:D)).to eq( [ {route_path:"ABD", distance:25}, {route_path:"ACD", distance:50} ] )
    end

    it 'return valid paths from A to E' do
      expect(map_info.find_all_routes(:A,:E)).to eq( [ {route_path:"ABE", distance:60}, {route_path:"ACDE", distance:80} ] )
    end
  end

  describe '#find_shortest_route' do
    it 'return the short ' do
      expect(map_info.find_shortest_route(:A,:D)).to eq({ route_path:"ABD", distance:25 })
    end
  end
end
