require 'rails_helper'

describe '/v1/books' do
  describe 'GET {id}' do
    let(:book) { create(:book) }
    let(:book_id) { book.id }
    let(:params) {}

    def api_call(_params)
      get "/v1/books/#{book_id}", as: :json
    end

    context 'negative tests' do
      context 'invalid book_id' do
        let(:book_id) { book.id + 1 }

        it_behaves_like '404'
        it_behaves_like 'valid API response'
      end
    end
    context 'positive tests' do
      context 'existing book' do
        let(:expected_values) do
          {
            id: Book.last.id,
            title: Book.last.title,
            category: Book.last.category,
            isbn: Book.last.isbn,
            price: Book.last.price,
            author: {
              first_name: Book.last.author.first_name,
            last_name: Book.last.author.last_name,
            birth: Book.last.author.birth.as_json,
            born_country: Book.last.author.born_country,
            biography: Book.last.author.biography
            }
          }
        end
        it_behaves_like '200'
        it_behaves_like 'valid API response'
        it_behaves_like 'json expected values'
      end
    end
  end

  describe 'POST book' do
    let(:valid_params) do
      {
        title: 'El árbol de la ciencia',
        category: 'story',
        isbn: 1,
        price: 950,
        author: {
          first_name: 'Pio',
        last_name: 'Baroja'
        }
      }
    end
    let(:params) { valid_params }

    def api_call(params)
      post '/v1/books',
           params: params,
           as: :json
    end

    context 'negative tests' do
      context 'missing required params' do
        context 'title' do
          let(:params) { valid_params.except(:title) }

          it_behaves_like '422'
          it_behaves_like 'valid API response'
          it_behaves_like 'contains inner_error message',
                          'title is missing'
        end
        context 'category' do
          let(:params) { valid_params.except(:category) }

          it_behaves_like '422'
          it_behaves_like 'valid API response'
          it_behaves_like 'contains inner_error message',
                          'category is missing'
        end
        context 'isbn' do
          let(:params) { valid_params.except(:isbn) }

          it_behaves_like '422'
          it_behaves_like 'valid API response'
          it_behaves_like 'contains inner_error message',
                          'isbn is missing'
        end
        context 'price' do
          let(:params) { valid_params.except(:price) }

          it_behaves_like '422'
          it_behaves_like 'valid API response'
          it_behaves_like 'contains inner_error message',
                          'price is missing'
        end
      end
    end
    context 'positive tests' do
      context 'valid email' do
        let(:expected_values) do
          {

          }
        end

        it_behaves_like '201'
        it_behaves_like 'valid API response'
        it_behaves_like 'json expected values'
      end
    end
  end
end
