class AddTimeToTweets < ActiveRecord::Migration
  def self.up
    change_table :tweets do |t|
      t.string :time_string
    end
  end

  def self.down
    remove_column :tweets, :time_string
  end
end
