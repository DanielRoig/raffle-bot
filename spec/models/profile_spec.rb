require 'rails_helper'

RSpec.describe Profile, type: :model do
  it { should belong_to(:user) }

  describe '.create' do
    let(:valid_params) { attributes_for(:profile) }
    let(:valid_profile) { build(:profile) }
    let(:valid_result) { valid_profile }
    let(:create_invalid_profile) do
      Profile.create(invalid_params)
    end
    let(:invalid_result) { create_invalid_profile }
    let(:invalid_params) { valid_params.merge(invalid_param) }

    context 'negative tests' do
      context 'nil description' do
        let(:invalid_param) { { description: nil } }

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
