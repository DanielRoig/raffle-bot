module API
  module V1
    module Resources
      class Authors < Grape::API
        DESCRIPTION = 'End-points related with authors'.freeze

        helpers do
          def ensure_author
            @author = Author.find_by(id: params[:id])

            unless @author
              raise API::Exceptions::ResourceNotFound,
                    "Author with id #{params[:id]} not found"
            end
          end
        end

        namespace 'authors', desc: DESCRIPTION do
          desc 'Returns author details',
               http_codes: [
                 {
                   code: 200,
                   model: API::V1::Entities::Author
                 }
               ],
          ignore_defaults: true

          params do
            requires :id, type: Integer
          end

          get ':id' do
            ensure_author
            status :ok
            author_view = ::Authors::ViewService.call(author: @author)
            present author_view, with: API::V1::Entities::Author
          end

          desc 'Create author',
               http_codes: [
                 {
                   code: 201, model: API::V1::Entities::Author
                 }
               ],
          ignore_defaults: true

          params do
            requires :first_name, type: String
            requires :last_name, type: String
            requires :email, type: String
            requires :birth, type: DateTime
            requires :born_country, type: String
            requires :biography, type: String
          end

          post do
            author = ::Authors::CreateService.call(first_name: params[:first_name],
                                          last_name: params[:last_name],
                                          email: params[:email],
                                          birth: params[:birth],
                                          born_country: params[:born_country],
                                          biography: params[:biography])
            status :created
            present author, with: API::V1::Entities::Author
          end
        end
      end
    end
  end
end
