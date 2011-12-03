class LinesController < ActionController::Base

  def show
    @line = Line.find_by_name(params[:name])
    @stations = @line.stations.group("station_name").order("latitude DESC").order("longitude DESC")
  end

end
