class Map < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :point_connections, presence: true

  serialize :point_connections, Hash

  def find_all_routes(origin, dest, route_path=nil, km=0)
    return if point_connections[origin].nil?

    route_path ||= origin

    return [ { route_path: "#{route_path}#{dest}", distance: km+point_connections[origin][dest] } ] if point_connections[origin].dig(dest)

    point_connections[origin].flat_map do |key,value|
      find_all_routes(key, dest, "#{route_path}#{key}", km+value)
    end
  end

  def find_shortest_route(origin, dest)
    routes_found = find_all_routes(origin, dest).try(:compact)

    routes_found.sort_by {|k| k[:distance] }.first if routes_found.present?
  end
end
