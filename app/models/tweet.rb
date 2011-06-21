class Tweet
include MongoMapper::Document
  key :data
  key :city_id, ObjectId
  key :user, ObjectId
  belongs_to :city
  has_one :tweeter
end
