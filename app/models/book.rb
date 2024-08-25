class Book < ApplicationRecord
  belongs_to :author
  enum category: {
    story: 1
  }

  validates :title, presence: true
  validates :category, presence: true
  validates :isbn, presence: true, uniqueness: { case_sensitive: true }
  validates :price, presence: true
end
