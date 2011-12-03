class AddHappinessStringToStation < ActiveRecord::Migration
  def self.up
    change_table :stations do |t|
      t.string :happiness_string
    end
  end

  def self.down
    remove_column :stations, :happiness_string
  end
end
