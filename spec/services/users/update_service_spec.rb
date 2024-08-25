require 'rails_helper'

RSpec.describe Users::UpdateService, type: :service do
  subject { described_class }

  describe '.call' do
    let(:user) { create(:user, :with_profiles) }
    let(:description) { 'test' }
    let(:result_user) do
      described_class.call(id: user.id, description: description)
    end

    context 'update a existing user' do
      before do
        user
      end
      it 'updates the user' do
        expect { result_user }.to change { Profile.count }.by(1)

        expect(result_user).to eq User.last
        expect(result_user.profiles.last.description).to eq(description)
      end
    end

    context 'update a exisitng user without new parameters' do
      before do
        user
      end
      let(:description) {}
      it 'does not create a new register' do
        expect { result_user }.not_to change { Profile.count }
      end
    end
  end
end
