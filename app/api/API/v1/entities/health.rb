module API
  module V1
    module Entities
      class Health < Grape::Entity
        expose :status, as: :otherName, documentation: { type: :string }
      end
    end
  end
end
