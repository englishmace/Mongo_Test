
MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
MongoMapper.database = "mongo_test_#{Rails.env}"
