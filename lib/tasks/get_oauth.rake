require 'rubygems'
require 'twitter_oauth'

options = YAML::load(File.open("#{Rails.root.to_s}/heartkeys.yml"))

task :get_token => :environment do
  client = TwitterOAuth::Client.new(
    :consumer_key     => options.consumer_key,
    :consumer_secret  => options.consumer_secret 
  )
  request_token = client.request_token

  puts "#{request_token.authorize_url}\n"
  puts "Hit enter when you have completed authorization."
  pin = STDIN.readline.chomp

  access_token = client.authorize(
    request_token.token,
    request_token.secret,
    :auth_verifier => pin
  )

  puts access_token.inspect
end
