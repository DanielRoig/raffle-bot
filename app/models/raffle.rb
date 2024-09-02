class Raffle < ApplicationRecord
  has_many :numbers, dependent: :destroy
  has_many :images, as: :imageable, dependent: :destroy

  validates :name, presence: true
  validates :first_number, :last_number, presence: true

  after_create :generate_numbers
  after_update :notify_users_if_waiting_payment

  enum status: { open: 0, waiting_payment: 1, closed: 2 }
  enum category: { multiple: 0, single: 1 }


  private

  def generate_numbers
    (first_number..last_number).each do |value|
      numbers.create(value:)
    end
  end

  def notify_users_if_waiting_payment
    if saved_change_to_status? && status == 'waiting_payment' && category == 'multiple'
      RafflePaymentNotifierWorker.perform_async(id)
    end
  end

  def t(key, options = {})
      I18n.t("raffle.#{key}", **options)
  end
end
  