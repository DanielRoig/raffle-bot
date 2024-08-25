require 'rails_helper'

describe '/v1/authors' do
  describe 'GET {id}' do
    let(:author) { create(:author) }
    let(:author_id) { author.id }
    let(:params) {}

    def api_call(_params)
      get "/v1/authors/#{author_id}", as: :json
    end

    context 'negative tests' do
      context 'invalid author_id' do
        let(:author_id) { author.id + 1 }

        it_behaves_like '404'
        it_behaves_like 'valid API response'
      end
    end
    context 'positive tests' do
      context ' existing author' do
        let(:expected_values) do
          {
            first_name: Author.last.first_name,
            last_name: Author.last.last_name,
            birth: Author.last.birth.as_json,
            born_country: Author.last.born_country,
            biography: Author.last.biography
          }
        end
        it_behaves_like '200'
        it_behaves_like 'valid API response'
        it_behaves_like 'json expected values'
      end
    end
  end

  describe 'POST author' do
    let(:valid_params) do
      {
        first_name: 'Pio',
        last_name: 'Baroja',
        email: 'pio_baroja@gen98.es',
        birth: '1872-12-28',
        born_country: 'España',
        biography: 'MyText'
      }
    end
    let(:params) { valid_params }

    def api_call(params)
      post '/v1/authors',
           params: params,
           as: :json
    end

    context 'negative tests' do
      context 'missing required params' do
        context 'first_name' do
          let(:params) { valid_params.except(:first_name) }

          it_behaves_like '422'
          it_behaves_like 'valid API response'
          it_behaves_like 'contains inner_error message',
                          'first_name is missing'
        end
        context 'last_name' do
          let(:params) { valid_params.except(:last_name) }

          it_behaves_like '422'
          it_behaves_like 'valid API response'
          it_behaves_like 'contains inner_error message',
                          'last_name is missing'
        end
      end
    end
    context 'positive tests' do
      context 'valid email' do
        let(:expected_values) do
          {
            first_name: Author.last.first_name,
            last_name: Author.last.last_name,
            birth: Author.last.birth.as_json,
            born_country: Author.last.born_country,
            biography: Author.last.biography
          }
        end
        it_behaves_like '201'
        it_behaves_like 'valid API response'
        it_behaves_like 'json expected values'
      end
    end
  end
end
