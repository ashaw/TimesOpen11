class Line < ActiveRecord::Base
  has_and_belongs_to_many :stations
  validates_uniqueness_of :name

  def get_raw_data

      data = {}

      station_data = self.stations.each  do |s|
          data[s.id] = s.get_happiness
      end

      data.to_json

  end

  def get_raw_data_night

      data = {}

      station_data = self.stations.each  do |s|
          data[s.id] = s.get_happiness_night
      end

      data.to_json

  end

  def happiness
  	self.stations.inject(0) { |sum, station| sum + station.happiness_index } / self.stations.count
  end

  def as_json(options={})
  	super(:methods => :happiness, :except => :happiness_index)
  end

end
