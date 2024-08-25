module API
  module V1
    module Entities
      class User < Grape::Entity
        expose :id, documentation: { type: :integer }

        expose :first_name, documentation: { type: :string }
        expose :last_name, documentation: { type: :string }
        expose :email, documentation: { type: :string }
        expose :description,
               documentation: { type: :string } do |user, _options|
          user.profiles.last.description
        end
      end
    end
  end
end
