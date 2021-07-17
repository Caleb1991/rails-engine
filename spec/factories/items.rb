FactoryBot.define do
  factory :item do
    name { Faker::Name.name }
    description { Faker::Lorem.paragraph}
    unit_price { Faker::Number.number(digits: 3)}
    merchant
  end
end
