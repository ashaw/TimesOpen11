namespace :classifier do
  desc "grab and train tweets"
  task :train => :environment do
    TweetClassifier.train!
  end
end