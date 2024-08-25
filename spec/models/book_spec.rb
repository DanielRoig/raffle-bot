require 'rails_helper'

RSpec.describe Book, type: :model do
  it { should belong_to(:author) }

  describe '.create' do
    let(:valid_params) { attributes_for(:book) }

    let(:valid_book) { build(:book) }
    let(:valid_result) { valid_book }
    let(:create_invalid_book) do
      Book.create(invalid_params)
    end
    let(:invalid_result) { create_invalid_book }
    let(:invalid_params) { valid_params.merge(invalid_param) }

    context 'negative tests' do
      context 'title is nil' do
        let(:invalid_param) { { title: nil } }

        it_behaves_like 'is invalid'
      end
      context 'category is nil' do
        let(:invalid_param) { { category: nil } }

        it_behaves_like 'is invalid'
      end
      context 'isbn is nil' do
        let(:invalid_param) { { isbn: nil } }

        it_behaves_like 'is invalid'
      end
      context 'price is nil' do
        let(:invalid_param) { { price: nil } }

        it_behaves_like 'is invalid'
      end
      context 'duplicated isbn' do
        let(:new_book) { create(:book) }
        let(:invalid_param) do
          {
            isbn: new_book.isbn
          }
        end

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
