class AddHappinessStringToStation < ActiveRecord::Migration
  def self.up
    change_table :tweets do |t|
      t.string :happiness_string
    end
    change_table :stations do |t|
      t.float :happiness_index
    end
    change_table :lines do |t|
      t.float :happiness_index
    end
  end

  def self.down
    remove_column :tweets, :happiness_string
    remove_column :stations, :happiness_index
    remove_column :lines, :happiness_index
  end
end
