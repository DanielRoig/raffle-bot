FactoryBot.define do
  factory :profile do
    user
    description { Faker::Lorem.paragraph }
  end
end
