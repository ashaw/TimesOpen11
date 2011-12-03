class Station < ActiveRecord::Base
  has_many :tweets
  has_and_belongs_to_many :lines
  
  def self.all_entrances
    self.all(:group => ["division, line, station_name"])
  end
end