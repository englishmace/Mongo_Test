class City
include MongoMapper::Document
  has_many :tweets
  has_many :tweeters

  # pulls all tweets tweeted since we last checked
  def update_tweets
    updated = false

    self.tweeters.each do |tweeter|
      new_tweets = Twitter.user_timeline(tweeter.user, :since_id => tweeter.latest_tweet, :trim_user => true)

      if tweeter.latest_tweet != new_tweets.first.id
        updated = true
      tweeter.latest_tweet = new_tweets.first.id
      tweeter.save

      for item in new_tweets do
        Tweet.new(:data => item, :city_id => self.id, :user => tweeter.id).save
      end
    end
    return updated
  end

  # pulls all backdated tweets for a new tweeter; initializes their twit_id & latest
  def init_tweets(tweeter)
    all_tweets = Twitter.user_timeline(tweeter.user, :trim_user => true, :count => 200)
    tweeter.latest_tweet = all_tweets.first.id
    tweeter.twit_id = all_tweets.first.user.id
    for item in all_tweets do
      Tweet.new(:data => item, :city_id => self.id, :user => tweeter.id).save
    end
  end

  # initializes a new tweeter & calls init_tweets
  def add_tweeter(username)
    tweeter = Tweeter.new(:user => username, :city_id => self.id)
    get_init_tweets(tweeter)
    tweeter.save
  end





  # test method
  def get_first_tweet(tweeter)
    temp = Twitter.user_timeline(tweeter.user).first
    Tweet.new(:city_id => self.id, :user => tweeter.id, :data => temp).save
  end
end
