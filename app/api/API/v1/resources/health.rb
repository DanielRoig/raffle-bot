module API
  module V1
    module Resources
      class Health < Grape::API
        DESCRIPTION = 'This is a description for API health endpoint'.freeze
        namespace 'health', desc: DESCRIPTION do
          desc 'Returns the health of the service'
          get do
            status :ok
            health = { status: 'tot ok',
                      other_data: 'no expose' }
            present health, with: API::V1::Entities::Health
          end
        end
      end
    end
  end
end
