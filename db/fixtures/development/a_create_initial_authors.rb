require './db/fixtures/development/seed_helper'

1.upto(SeedHelper.authors_to_create) do |index1|
  Author.seed(:email) do |author|
    author.first_name = Faker::Name.first_name
    author.last_name = Faker::Name.last_name
    author.birth = Faker::Date.between(from: 200.years.ago, to: 18.years.ago) 
    author.born_country = Faker::Address.country
    author.biography = Faker::Lorem.paragraph
    author.email = SeedHelper.predictable_email(index1, role: :author)
  end
end