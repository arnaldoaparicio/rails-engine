FactoryBot.define do
  factory :item do
    name { Faker::Games::Zelda.item }
    description { Faker::Lorem.sentence }
    unit_price { Faker::Number.decimal(l_digits: 2) }
  end
end
