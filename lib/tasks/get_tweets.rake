require 'pp'
require "#{Rails.root}/lib/get_auth"

task :get_tweets => :environment do
  client = HappySubways.get_auth

  Station.all.each do |entrance|
      next if entrance.tweets.size > 0
      
      lat =  entrance.latitude
      long = entrance.longitude
      station_id = entrance.id
      puts station_id
      raw = client.search.json? :geocode => "#{lat},#{long},0.1km", :rpp => 100, :lang => "en", :q => ""
      bodies = raw.results.map(&:text)
      bodies.each do |tweet|
        t = Tweet.new({:station_id => station_id, :text => tweet})
        t.save
      end
  end
end
