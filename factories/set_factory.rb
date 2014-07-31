FactoryGirl.define do
  factory :set do
    artist { Faker::Name.name }
    title { Faker::Commerce.product_name }
    date_aired { Array(Date.new(2014,5,1)..Date.today).sample }
    filepath { "#{artist}\ -\ #{title}\ -\ #{date_aired}.mp3" }
  end

  trait :with_tracks do
    after :create do |track|
      FactoryGirl.create_list :track, 3, :set => set
    end
  end
end
