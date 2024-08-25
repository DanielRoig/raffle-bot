require './db/fixtures/development/seed_helper'

User.find_each.with_index do |user, index|
    1.upto(1) do |index_2|
      Profile.seed do |profile|
        profile.user = user
        profile.description = Faker::Lorem.paragraph
      end
    end
end
