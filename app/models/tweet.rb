class Tweet
include MongoMapper::Document
  key :data#, Hashie::Rash
  key :city_id, ObjectId
  key :user, ObjectId
  belongs_to :city
  has_one :tweeter
  def wheres_wally
    puts Twitter.user("wally").location
  end
  def wheres(username)
    puts Twitter.user(username).location
  end
  def said(username)
    Twitter.user_timeline(username).first
  end
end
