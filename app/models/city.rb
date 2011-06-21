class City
include MongoMapper::Document
  has_many :tweets
  has_many :tweeters
  def get_tweets(tweeter)
    tweets = Twitter.user_timeline(tweeter.user, :since_id => tweeter.latest_tweet)
    tweeter.lastest_tweet = tweets.first.id
    for item in tweets do
      Tweet.new(:data => item, :city_id => self.id, :user => tweeter.id).save
    end
  end
  def get_first_tweet(tweeter)
    temp = Twitter.user_timeline(tweeter.user).first
    Tweet.new(:city_id => self.id, :user => tweeter.id, :data => temp).save
  end


end
