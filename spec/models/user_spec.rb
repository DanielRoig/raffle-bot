require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:profiles) }

  describe '.create' do
    let(:valid_params) { attributes_for(:user) }

    let(:valid_user) { create(:user) }
    let(:valid_result) { valid_user }
    let(:create_invalid_user) do
      User.create(invalid_params)
    end
    let(:invalid_result) { create_invalid_user }
    let(:invalid_params) { valid_params.merge(invalid_param) }

    context 'negative tests' do
      context 'first_name is nil' do
        let(:invalid_param) { { first_name: nil } }

        it_behaves_like 'is invalid'
      end
      context 'last_name is nil' do
        let(:invalid_param) { { last_name: nil } }

        it_behaves_like 'is invalid'
      end
      context 'email is nil' do
        let(:invalid_param) { { email: nil } }

        it_behaves_like 'is invalid'
      end
      context 'password is nil' do
        let(:invalid_param) { { password: nil } }

        it_behaves_like 'is invalid'
      end
    end
    context 'positive tests' do
      context 'required valid params' do
        it_behaves_like 'is valid'
      end
    end
  end
end
