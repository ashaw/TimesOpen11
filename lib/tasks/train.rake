namespace :classifier do
  desc "grab and train tweets"
  task :train => :environment do
    TweetClassifier.train!
  end

  desc "classify"
  task :classify => :environment do
    classifier = TweetClassifier.new

    Tweet.all.each do |t|
      t.happiness_string = classifier.classify t.text
      t.save
    end
  end
end