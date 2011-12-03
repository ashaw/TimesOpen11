class Station < ActiveRecord::Base
  has_many :tweets
end