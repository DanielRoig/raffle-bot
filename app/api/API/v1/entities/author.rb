module API
  module V1
    module Entities
      class Author < Grape::Entity
        expose :first_name, documentation: { type: :string }
        expose :last_name, documentation: { type: :string }
        expose :birth, documentation: { type: :Date }
        expose :born_country, documentation: { type: :string }
        expose :biography, documentation: { type: :string }
      end
    end
  end
end
