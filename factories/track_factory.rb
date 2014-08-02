FactoryGirl.define do
  factory :track do
    artist { Faker::Name.name }
    title { Faker::Commerce.product_name }
    track_number { 1 }
    filepath { "" }
  end
end
