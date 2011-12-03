class Station < ActiveRecord::Base
  has_many :tweets
  has_and_belongs_to_many :lines  
end