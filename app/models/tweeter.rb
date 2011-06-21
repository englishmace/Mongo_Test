class Tweeter
  include MongoMapper::Document
  key :user, String
  key :twit_id, Integer
  key :city_id, ObjectId
  key :latest_tweet, Integer
  belongs_to :city
end
