# from http://www.lrec-conf.org/proceedings/lrec2010/pdf/385_Paper.pdf -ish
require "#{Rails.root}/lib/get_auth"

class TweetClassifier
  GOOD      = ':)'
  BAD       = ':('
  SEARCH    = 'http://search.twitter.com/search.json'
  ROOT      = File.dirname(__FILE__)
  MODELS    = File.join(ROOT, 'models')
  STEMMER   = Lingua::Stemmer.new
  SAFEWORDS = ["the","and","to","of","a","i","in","was","he","that","it","his","her","you","as","had","with","for","she","not","at","but","be","my","on","have","him","is","said","me","which","by","so","this","all","from","they","no","were","if","would","or","when","what","there","been","one","could","very","an"]

  def initialize
    @features   = {}
    @categories = []
    category(:good)
    category(:bad)
  end

  def classify(doc)
    max = 0
    p = 0
    best = :unknown
    @categories.each do |cat|
      p = probability(cat, doc)
      if p > max
        max = p
        best = cat
      end
    end
    best
  end

  def probability(category, doc)
    category_probability = category_count(category) / total
    document_probability(category, doc) / category_probability
  end

  def category(sym)
    grab_tweets(sym).each do |tweet|
      as_features(tweet).each do |word|
        @features[word]      ||= {}
        @features[word][sym] ||= 0.to_f
        @features[word][sym]  += 1
        @categories << sym
        @categories.uniq!
      end
    end
  end

  def document_probability(cat, doc)
    as_features(doc).inject(1) { |prob, feature| prob * weighted_probability(cat, feature) }
  end

  def as_features(doc)
    doc.split(/\W+/).map { |word|
      next if word.length > 20 || word.length < 2
      next if SAFEWORDS.include? word
      STEMMER.stem(word.downcase)
    }.compact
  end

  def weighted_probability(cat, feature)
    assumed = 0.5
    weight  = 1
    totals  = @categories.inject(0) { |sum, category| sum + feature_count(category, feature) }
    ((weight * assumed) + (totals * feature_probability(cat, feature))) / (weight + totals)
  end

  def feature_probability(cat, feature)
    return 0 if category_count(cat) == 0
    return feature_count(cat, feature) / category_count(cat)
  end

  def category_count(sym)
    @features.values.reduce(0) do |memo, value|
      memo + (value[sym] || 0)
    end
  end

  def total
    @categories.inject(0) {|sum, cat| sum + category_count(cat) }
  end

  def feature_count(sym, feature)
    return @features[feature][sym] if @features[feature] && @features[feature][sym]
    0
  end

  def good_words
    GOOD
  end

  def bad_words
    BAD
  end

  def grab_tweets(cons)
    FileUtils.mkdir_p MODELS unless File.exists? MODELS
    training_file = File.join(ROOT, "models", "#{cons}_words.train")
    return File.read(training_file).split("\n") if File.exists? training_file

    client = HappySubways.get_auth
    send("#{cons}_words").map { |word|
      resp = (1..10).map do |idx|
        client.search.json?(:q => word, :page => idx, :lang => :en, :rpp => 100).results
      end.flatten
      resp.map do |tweet|
        text = tweet.text.gsub("\n", "")
        File.open(training_file, (File::WRONLY | File::APPEND | File::CREAT)) { |f| f.puts text }
        text
      end
    }.flatten
  end

  def self.train!
    FileUtils.rm_r MODELS if File.exists? MODELS
    TweetClassifier.new
  end
end


