class AddLineTable < ActiveRecord::Migration
  def self.up
    create_table :lines do |t|
      t.string :name
    end
    create_table :lines_stations, :id => false do |t|
      t.integer :station_id, :unique => true
      t.integer :line_id, :unique => true
    end
  end

  def self.down
    drop_table :lines
    drop_table :lines_stations
  end
end
