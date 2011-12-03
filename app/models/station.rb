class Station < ActiveRecord::Base
  has_many :tweets
  
  def self.all_entrances
    self.all(:group => ["division, line, station_name"])
  end
end