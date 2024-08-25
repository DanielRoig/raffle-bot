require 'rails_helper'

RSpec.describe Author, type: :model do
  it { should have_many(:books) }

  describe '.create' do
    let(:valid_params) { attributes_for(:author) }

    let(:valid_author) { create(:author) }
    let(:valid_result) { valid_author }
    let(:create_invalid_author) do
      Author.create(invalid_params)
    end
    let(:invalid_result) { create_invalid_author }
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
      context 'duplicated email' do
        let(:new_author) { create(:author) }
        let(:invalid_param) do
          {
            email: new_author.email
          }
        end

        it_behaves_like 'is invalid'
      end
    end
    context 'positive tests' do
      context 'required valid params' do
        it_behaves_like 'is valid'
      end
      context 'email is nil' do
        let(:invalid_param) { { email: nil } }

        it_behaves_like 'is valid'
      end
    end
  end
end
