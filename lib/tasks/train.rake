namespace :classifier do
  desc "classify"
  task :classify => :environment do
    classifier = TweetClassifier.new

    Tweet.order("id ASC").all.each do |t|
      t.happiness_string = classifier.classify t.text
      t.save
      puts "#{t.id}: #{t.happiness_string}: #{t.text[0..80]}"
    end
  end
end