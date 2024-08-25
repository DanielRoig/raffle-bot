class User < ApplicationRecord
  acts_as_paranoid

  has_many :profiles, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :email, format: { with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/ },
                    uniqueness: { case_sensitive: true }
  validates :password, presence: true
end
