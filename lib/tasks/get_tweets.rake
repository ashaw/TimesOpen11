require 'pp'

options = YAML::load(File.open('../../heartkeys.yml'))

task :get_tweets => :environment do
TWITTER_AUTH = {
  :type             =>  :oauth,
  :consumer_key     => option.consumer_key,
  :consumer_secret  => option.consumer_secret, 
  :token            => option.token,
  :token_secret     => options.token_secret
}

client = Grackle::Client.new(:auth=>TWITTER_AUTH)

Station.all_entrances.each do |entrance|
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
