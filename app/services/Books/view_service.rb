module Books
  class ViewService
    include Service

    def call
      book
    end

    attr_accessor :book
  end
end
