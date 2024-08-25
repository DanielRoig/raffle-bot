FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password { Faker::Internet.password }

    sequence(:email) { |n| "pio.baroja#{n}@gen98.es" }

    trait :with_profiles do
      after(:create) do |user|
        FactoryBot.create_list(:profile, 10, user: user)
      end
    end
  end
end
