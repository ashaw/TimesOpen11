class CreateInitialDb < ActiveRecord::Migration
  def self.up
    create_table :stations do |t|
      t.string :division
      t.string :line
      t.string :station_name
      t.string :route_1
      t.string :route_2
      t.string :route_3
      t.string :route_4
      t.string :route_5
      t.string :route_6
      t.string :route_7
      t.string :route_8
      t.string :route_9
      t.string :route_10
      t.string :route_11
      t.string :corner
      t.float :latitude
      t.float :longitude
    end
    
    create_table :tweets do |t|
      t.integer :station_id
      t.text :text
      t.float :happiness
      t.string :language
    end
  end

  def self.down
    remove_table :stations
    remove_table :tweets
  end
end
