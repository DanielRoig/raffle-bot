require './db/fixtures/development/seed_helper'

Author.find_each.with_index do |author, index|

    1.upto(SeedHelper.books_to_create) do |index_2|
      Book.seed do |book|
        book.author = author
        book.title = Faker::Book.title
        book.category = 'story'
        book.isbn = (index.to_s + index_2.to_s).to_i
        book.price = Faker::Number.between(from: 200, to: 10_000)
      end
    end
end
