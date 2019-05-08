class MapController < ApplicationController

  def create
    @map = Map.new(map_params)

    if @map.save
      render json: @map, status: :created
    else
      render json: @map.errors, status: :bad_request
    end
  end

  private

  def map_params
    params.require(:map).to_unsafe_h
  end
end
