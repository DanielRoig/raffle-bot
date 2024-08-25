require 'rails_helper'

describe '/v1/users' do
  describe 'GET' do
    let(:user) { create(:user, :with_profiles) }
    let(:user_id) { user.id }
    let(:params) {}

    def api_call(_params)
      get '/v1/users/', as: :json
    end

    context 'positive tests' do
      context 'existing user' do
        before do
          user
        end

        let(:expected_values) do
          [{
            id: User.last.id,
            email: User.last.email,
            first_name: User.last.first_name,
            last_name: User.last.last_name,
            description: User.last.profiles.last.description
          }]
        end

        it_behaves_like '200'
        it_behaves_like 'valid API response'
        it_behaves_like 'json expected values'
      end

      context 'no users' do
        let(:expected_values) { [] }

        it_behaves_like '200'
        it_behaves_like 'valid API response'
        it_behaves_like 'json expected values'
      end
    end
  end

  describe 'DELETE {id}' do
    let(:user) { create(:user, :with_profiles) }
    let(:user_id) { user.id }
    let(:params) {}

    def api_call(_params)
      delete "/v1/users/#{user_id}", as: :json
    end

    context 'negative tests' do
      context 'invalid user_id' do
        let(:user_id) { user.id + 1 }

        it_behaves_like '404'
        it_behaves_like 'valid API response'
      end
    end

    context 'positive tests' do
      context 'existing user' do
        it_behaves_like '204'
        it_behaves_like 'valid API response'
      end
    end
  end

  describe 'POST' do
    let(:valid_params) do
      {
        email: 'test@test.com',
        first_name: 'test',
        last_name: 'test',
        description: 'description',
        password: 'password'
      }
    end

    let(:user) { create(:user) }

    let(:invalid_params) do
      {
        email: user.email,
        first_name: 'test',
        last_name: 'test',
        description: 'description'
      }
    end

    def api_call(_params)
      post '/v1/users/', params: params, as: :json
    end

    context 'negative tests' do
      context 'email already exist' do
        let(:params) { invalid_params }

        it_behaves_like '404'
        it_behaves_like 'valid API response'
      end
    end

    context 'positive tests' do
      context 'create user' do
        before do
          user
        end
        let(:params) { valid_params }
        let(:expected_values) do
          {
            id: User.last.id,
            email: User.last.email,
            first_name: User.last.first_name,
            last_name: User.last.last_name,
            description: User.last.profiles.last.description
          }
        end

        it_behaves_like '201'
        it_behaves_like 'valid API response'
        it_behaves_like 'json expected values'
      end
    end
  end

  describe 'PUT' do
    let(:user) { create(:user, :with_profiles) }
    let(:user_id) { user.id }
    let(:valid_params) do
      {
        description: 'description'
      }
    end

    let(:invalid_params) do
      {
        email: user.email,
        first_name: 'test',
        last_name: 'test',
        description: 'description'
      }
    end

    def api_call(_params)
      put "/v1/users/#{user_id}", params: params, as: :json
    end

    context 'negative tests' do
      context 'invalid user_id' do
        let(:user_id) { user.id + 1 }
        let(:params) { invalid_params }

        it_behaves_like '404'
        it_behaves_like 'valid API response'
      end
    end

    context 'positive tests' do
      context 'update user field' do
        before do
          user
        end

        let(:params) { valid_params }

        let(:expected_values) do
          {
            id: User.last.id,
            email: User.last.email,
            first_name: User.last.first_name,
            last_name: User.last.last_name,
            description: valid_params[:description]
          }
        end

        it_behaves_like '200'
        it_behaves_like 'valid API response'
        it_behaves_like 'json expected values'
      end
    end
  end
end
