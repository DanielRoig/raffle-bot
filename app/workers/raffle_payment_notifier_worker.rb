
class RafflePaymentNotifierWorker
  include Sidekiq::Worker

  def perform(raffle_id)
    raffle = Raffle.find(raffle_id)
    users = User.joins(:numbers).where(numbers: { raffle: }).distinct

    users.each do |user|
   
      numbers_count = user.numbers.count

      Telegram.bot.send_message(
        chat_id: user.telegram_id,
        text: t('text', raffle_name: raffle.name, numbers_count: user.numbers.count),
        reply_markup: {
          inline_keyboard: [
            [{ text: t('pay_number', price: format_price(raffle.price * numbers_count), numbers_count:), callback_data: "show_payment_funnel" }]
          ]
        }
      )
      sleep(5)
    end
  end

  private

  def format_price(cents)
    PriceFormatter.format_price(cents)
  end

  def t(key, options = {})
    I18n.t("payment_notifier.#{key}", **options)
  end
end
