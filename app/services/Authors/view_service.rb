module Authors
  class ViewService
    include Service

    def call
      author
    end

    attr_accessor :author
  end
end
