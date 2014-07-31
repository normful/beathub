FactoryGirl.define do
  factory :set, class: Music::Set  do
    artist { Faker::Name.name }
    title { Faker::Commerce.product_name }
    date_aired { Array(Date.new(2014,5,1)..Date.today).sample }
    filepath { "#{artist}\ -\ #{title}\ -\ #{date_aired}.mp3" }
  end
end
