FactoryBot.define do
  factory :book do
    author
    title { Faker::Lorem.sentence }
    category { 1 }
    price { Faker::Number.within(range: 1..10_000) }

    sequence(:isbn) { |n| n }
  end
end
