namespace :classifier do
  desc "grab and train tweets"
  task :train => :environment do
    TweetClassifier.train!
  end

  desc "classify"
  task :classify => :environment do
    classifier = TweetClassifier.new

    Tweet.where(:happiness_string => nil).order("id ASC").all.each do |t|
      t.happiness_string = classifier.classify t.text
      t.save
      puts "#{t.id}: #{t.happiness_string}: #{t.text[0..80]}"
    end
  end
end