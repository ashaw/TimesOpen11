class LinesController < ApplicationController

  def index
    @lines = Line.order(:name).all.to_json
  end

  def show
    @line = Line.find_by_name(params[:name])
    @stations = @line.stations.group("station_name").order("latitude DESC").order("longitude DESC")
  end
end
