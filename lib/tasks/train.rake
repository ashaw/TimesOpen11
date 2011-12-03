namespace :classifier do
  desc "grab and train tweets"
  task :train do
    TweetClassifier.new
  end
end