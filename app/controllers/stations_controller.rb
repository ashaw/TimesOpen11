class StationsController < ApplicationController
  def index
    @stations = Station.all
  end

  def show
    @station = Station.find(params[:id])
  end

  def voronoi
  	@min_lat = @min_lng = 180
  	@max_lat = @max_lng = -180

  	max_happy = Station.maximum(:happiness_index)
  	min_happy = Station.minimum(:happiness_index)
  	happy_r = max_happy - min_happy

  	@stations = Station.all
  	@stations.map! do |station|
  		lat = station.latitude
  		lng = station.longitude
  		@min_lat = lat if lat < @min_lat
  		@min_lng = lng if lng < @min_lng
  		@max_lat = lat if lat > @max_lat
  		@max_lng = lng if lng > @max_lng
  		# happy, sad, total = station.get_happiness
  		# happy_index = happy / total
  		happy_index = (station.happiness_index - min_happy) / happy_r
		  [lat, lng, happy_index]
		end

		lat_r = @max_lat - @min_lat
		lng_r = @max_lng - @min_lng

  	@stations.map! do |station|
  		lat = station[0]
  		lng = station[1]

  		lat = ((lat - @min_lat) / lat_r)
  		lng = ((lng - @min_lng) / lng_r)

		  [lat, lng, station[2]]
  	end


  	render :layout => false
  end
end