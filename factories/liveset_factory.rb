FactoryGirl.define do
  factory :liveset do
    artist { Faker::Name.name }
    title { Faker::Commerce.product_name }
    date_aired { Array(Date.new(2014,5,1)..Date.today).sample }
    filepath { "/assets/music/#{artist} - #{title} #{date_aired}/#{artist} - #{title} #{date_aired}.mp3" }
    cuepath { "/assets/music/#{artist} - #{title} #{date_aired}/#{artist} - #{title} #{date_aired}.cue" }
    zippath { "/assets/music/#{artist} - #{title} #{date_aired}/#{artist} - #{title} #{date_aired}.zip" }
  end
end
