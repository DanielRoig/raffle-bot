module API
  module V1
    module Entities
      class Book < Grape::Entity
        expose :id, documentation: { type: :integer }
        expose :title, documentation: { type: :string }
        expose :category, documentation: { type: :string }
        expose :isbn, documentation: { type: :integer }
        expose :price, documentation: { type: :string }
        expose :author, using: API::V1::Entities::Author
      end
    end
  end
end
