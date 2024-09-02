class Number < ApplicationRecord
  belongs_to :raffle
  belongs_to :user, optional: true

  enum status: { available: 0, reserved: 1, pending_approval: 2, paid: 3 }

  scope :available, -> { where(user: nil) }

  validates :value, presence: true, uniqueness: { scope: :raffle_id }
  validate :validate_number_selection, if: -> { user.present? }

  before_update :clear_user_if_available

  def formatted_value
    value.to_s.rjust(2,'0')
  end

  private

  def clear_user_if_available
    self.user = nil if status_changed? && available?
  end

  def validate_number_selection
    if raffle.single? && raffle.numbers.exists?(user_id: user_id)
      errors.add(:user, 'solo puede seleccionar un número en esta rifa')
    end
  end
end
