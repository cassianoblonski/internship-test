class CheaperRouteController < ApplicationController
  before_action :set_map, only: [:find_cheaper_route]

  def find_cheaper_route
    @shortest_route = @map.find_shortest_route(params[:initial_point].to_sym, params[:destination].to_sym)

    if @shortest_route
      data = {
        'Map Name': @map.name,
        'Route Path': @shortest_route[:route_path],
        'Distance': @shortest_route[:distance],
        'Cost': calculate_cost
      }
      render json: data, status: :ok
    else
      error = {
        'title':  'One point is not valid',
        'detail': 'You must provide both valid points (points are case sensitive).'
      }
      render json: error, status: :unprocessable_entity
    end
  end

  private
  def route_params
    params.require(:data).permit(:map_name, :initial_point, :destination, :cost)
  end

  def set_map
    @map = Map.find_by(name: params[:map_name])

    if @map == nil
      error = {
        'title':  'Map not found',
        'detail': 'You must provide a valid map name in order to find the cheaper route.'
      }
      render json: error, status: 404
    end
  end

  def calculate_cost
    @shortest_route[:distance].to_f * params[:cost].to_f
  end
end
