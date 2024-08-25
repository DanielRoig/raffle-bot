require 'rails_helper'

RSpec.describe Authors::CreateService, type: :service do
  subject { described_class }

  describe '.call' do
    let(:result_author) do
      described_class.call(first_name: 'test', last_name: 'test',
email: 'test@test.com', birth: '21-4-1995', born_country: 'country', biography: 'biography')
    end

    context 'when we want to create a new author' do
      it 'create a new author' do
        expect(result_author).to eq Author.last
      end
    end
  end
end
