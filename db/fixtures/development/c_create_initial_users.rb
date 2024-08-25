require './db/fixtures/development/seed_helper'

1.upto(SeedHelper.users_to_create) do |index1|
  User.seed do |user|
    user.first_name = Faker::Name.first_name
    user.last_name = Faker::Name.last_name
    user.email = SeedHelper.predictable_email(index1, role: :user)
    user.password = Faker::Internet.password
  end
end