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

end
