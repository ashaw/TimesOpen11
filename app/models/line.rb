class Line < ActiveRecord::Base
  has_and_belongs_to_many :stations
  validates_uniqueness_of :name
  
  def all_entrances
    self.stations.
  end
end