require 'rails_helper'

RSpec.describe Books::CreateService, type: :service do
  subject { described_class }

  describe '.call' do
    let(:author) { create(:author) }
    let(:result_book) do
      described_class.call(title: 'test', category: 'story',
isbn: 1, author: author, price: 2)
    end

    context 'when we want to create a new book' do
      it 'create a new book' do
        expect(result_book).to eq Book.last
      end
    end
  end
end
