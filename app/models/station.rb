class Station < ActiveRecord::Base
  has_many :tweets
  has_and_belongs_to_many :lines  

  def get_happiness
      happy = self.tweets.where(:happiness_string => "good").count
      sad = self.tweets.where(:happiness_string => "bad").count
      [happy.to_f,sad.to_f,happy.to_f+sad.to_f]
  end


end
