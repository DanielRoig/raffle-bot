require 'rails_helper'

RSpec.describe Users::CreateService, type: :service do
  subject { described_class }

  describe '.call' do
    let(:result_user) do
      described_class.call(first_name: 'test', last_name: 'test',
email: 'test@test.com', password: 'password', description: 'Description')
    end

    context 'when we want to create a new user' do
      it 'create a new user' do
        expect(result_user).to eq User.last
        expect(result_user.profiles).to eq User.last.profiles
      end
    end
  end
end
