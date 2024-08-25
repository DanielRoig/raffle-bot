module Books
  class CreateService
    include Service

    def call
      Book.create!(author: author, title: title, category: category,
isbn: isbn, price: price)
    end

    attr_accessor :title, :category, :isbn, :price, :author
  end
end
