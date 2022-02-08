FactoryBot.define do
  factory :merchant do
    name { Faker::Games::Zelda.character }
  end
end
