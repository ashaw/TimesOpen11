class Station < ActiveRecord::Base
  has_many :tweets
  has_and_belongs_to_many :lines  

  def get_happiness
      happy = self.tweets.all.select{|t| t.happiness_string == "good" && t.time_string == nil}.length
      sad = self.tweets.all.select{|t| t.happiness_string == "bad" && t.time_string == nil}.length
      [happy.to_f,sad.to_f,happy.to_f+sad.to_f]
  end
  
  def get_happiness_night
      happy = self.tweets.all.select{|t| t.happiness_string == "good" && t.time_string == "night"}.length
      sad = self.tweets.all.select{|t| t.happiness_string == "bad" && t.time_string == "night"}.length
      [happy.to_f,sad.to_f,happy.to_f+sad.to_f]
  end


end
