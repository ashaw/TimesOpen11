module HappySubways
  def self.get_auth
    options = YAML::load(File.open("#{Rails.root.to_s}/heartkeys.yml"))

    tauth = {
      :type             =>  :oauth,
      :consumer_key     => options['consumer_key'],
      :consumer_secret  => options['consumer_secret'], 
      :token            => options['token'],
      :token_secret     => options['token_secret']
    }

    Grackle::Client.new(:auth=>tauth)
  end
end