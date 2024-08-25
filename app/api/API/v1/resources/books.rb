module API
  module V1
    module Resources
      class Books < Grape::API
        DESCRIPTION = 'End-points related with books'.freeze

        helpers do
          def ensure_book
            @book = Book.find_by(id: params[:id])

            unless @book
              raise API::Exceptions::ResourceNotFound,
                    "Book with id #{params[:id]} not found"
            end
          end

          def find_or_create_author
            @author = Author.find_or_create_by!(first_name: params.dig(:author, :first_name),
                                               last_name: params.dig(
                                                 :author, :last_name
                                               ))

            unless @author
              raise API::Exceptions::InvalidOperation,
                    'Unable to crate Author'
            end
          end
        end

        namespace 'books', desc: DESCRIPTION do
          desc 'Returns book details',
               http_codes: [
                 {
                   code: 200,
                   model: API::V1::Entities::Book
                 }
               ],
          ignore_defaults: true

          params do
            requires :id, type: Integer
          end

          get ':id' do
            ensure_book
            status :ok
            book_view = ::Books::ViewService.call(book: @book)
            present book_view, with: API::V1::Entities::Book
          end

          desc 'Create book',
               http_codes: [
                 {
                   code: 201
                 }
               ],
          ignore_defaults: true

          params do
            requires :title, type: String
            requires :category, type: String
            requires :isbn, type: Integer
            requires :price, type: Integer
            requires :author, type: Hash do
              requires :first_name,
                       type: String
              requires :last_name,
                       type: String
            end
          end

          post do
            find_or_create_author
            ::Books::CreateService.call(title: params[:title], category: params[:category],
                                        isbn: params[:isbn], price: params[:price],
                                        author: @author)

            status :created
          end
        end
      end
    end
  end
end
