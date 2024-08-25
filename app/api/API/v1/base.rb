module API
  module V1
    class Base < Grape::API
      use ErrorHandler

      version 'v1', using: :path
      mount API::V1::Resources::Health
      mount API::V1::Resources::Books
      mount API::V1::Resources::Authors
      mount API::V1::Resources::Users

      route :any, '*path' do
        raise API::Exceptions::InvalidOperation,
              "No such route '#{request.path}'"
      end

      if Rails.application.config.api_docs
        require 'grape-swagger'

        add_swagger_documentation(
          info: {
            title: 'rails_api_bolierplate',
            description: File.read(File.expand_path('README.md', __dir__)),
            contact_name: 'rails_api_bolierplate',
            contact_email: 'dev@rails_api_bolierplate.com'
          },
          security_definitions: {
            authorization: {
              type: 'apiKey',
              name: 'Authorization',
              in: 'header'
            }
          },
          security: [
            {
              authorization: []
            }
          ],
          host: ''
        )
      end
    end
  end
end
