class Artist
  include MongoMapper::Document

  key :age, Integer
  def print_thing
    puts 'Hi!'
  end
end
