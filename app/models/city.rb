class City
include MongoMapper::Document
  has_many :tweets
  has_many :tweeters

  def get_tweets
    self.tweeters.each do |tweeter|
      new_tweets = Twitter.user_timeline(tweeter.user, :since_id => tweeter.latest_tweet, :trim_user => true)
      tweeter.latest_tweet = new_tweets.first.id
      tweeter.save
      for item in new_tweets do
        Tweet.new(:data => item, :city_id => self.id, :user => tweeter.id).save
      end
    end
  end

  def get_init_tweets(tweeter)
    all_tweets = Twitter.user_timeline(tweeter.user, :trim_user => true, :count => 200)
    tweeter.latest_tweet = all_tweets.first.id
    tweeter.twit_id = all_tweets.first.user.id
    for item in all_tweets do
      Tweet.new(:data => item, :city_id => self.id, :user => tweeter.id).save
    end
  end

  def add_tweeter(username)
    tweeter = Tweeter.new(:user => username, :city_id => self.id)
    get_init_tweets(tweeter)
    tweeter.save
  end






  def get_first_tweet(tweeter)
    temp = Twitter.user_timeline(tweeter.user).first
    Tweet.new(:city_id => self.id, :user => tweeter.id, :data => temp).save
  end
end
