FactoryBot.define do
  factory :author do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    birth { Faker::Date.between(from: 200.years.ago, to: 18.years.ago) }
    born_country { Faker::Address.country }
    biography { Faker::Lorem.paragraph }

    sequence(:email) { |n| "pio.baroja#{n}@gen98.es" }

    trait :with_books do
      after(:create) do |author|
        FactoryBot.create_list(:book, 10, author: author)
      end
    end
  end
end
