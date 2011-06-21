class Tweeter
  include MongoMapper::Document
  key :user, String
  key :city_id, ObjectId
  key :latest_tweet, Integer
  belongs_to :city
end
