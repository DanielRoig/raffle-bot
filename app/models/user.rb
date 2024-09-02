class User < ApplicationRecord
  ADMIN_USER_ID = ENV['ADMIN_USER_ID'].split(',').map(&:to_i)

  has_many :numbers
  has_one :image, as: :imageable, dependent: :destroy

  validates :telegram_id, presence: true, uniqueness: true

  scope :with_numbers, -> { joins(:numbers).distinct }

  def admin?
    ADMIN_USER_ID.include?(telegram_id)
  end
end
