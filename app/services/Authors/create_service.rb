module Authors
  class CreateService
    include Service

    def call
      Author.create!(first_name: first_name,
                     last_name: last_name,
                     email: email,
                     birth: birth,
                     born_country: born_country,
                     biography: biography)
    end

    attr_accessor :first_name, :last_name, :email, :birth, :born_country,
                  :biography
  end
end
