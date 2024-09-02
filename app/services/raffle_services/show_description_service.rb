module RaffleServices
  class ShowDescriptionService
    include Service

    def call
      return Message::NoActiveRaffle.new(user) unless raffle

      Message::Message.new(text, buttons, 'text', message_action)
    end

    private

    def text
      return single_raffle_text if raffle.category == 'single'
      return multiple_raffle_text if raffle.category == 'multiple'
    end

    def single_raffle_text
      numbers_count = raffle.numbers.count

      t('single_raffle_text',
        name: raffle.name,
        date: raffle.created_at.strftime('%d/%m/%Y'),
        description: raffle.description,
        numbers_count:,
        reserved: raffle.numbers.reserved.count,
        image_count: raffle.images.count,
        status: I18n.t("raffle.#{raffle.status}"),
      )
    end

    def multiple_raffle_text
      numbers_count = raffle.numbers.count

      t('multiple_raffle_text',
        name: raffle.name,
        date: raffle.created_at.strftime('%d/%m/%Y'),
        description: raffle.description,
        numbers_count:,
        reserved: raffle.numbers.reserved.count,
        paid: raffle.numbers.paid.count,
        price: format_price(raffle.price),
        image_count: raffle.images.count,
        status: I18n.t("raffle.#{raffle.status}"),
        payment_info: raffle.payment_info
      )
    end

    def buttons
      buttons = user_raffle_buttons
      buttons += admin_buttons if user.admin?
      buttons
    end

    def admin_buttons
      return [[create_raffle_button]] unless raffle

      [
        [admin_raffle_button, verify_payments_button],
        [change_raffle_status_button, edit_raffle_button],
        [summarize_raffle_button]
      ]
    end

    def user_raffle_buttons
      buttons = [
        [show_raffle_button, available_numbers_button],
        [],
        []
      ]

      buttons[1].push(show_raffle_photos) if raffle.images.any?
      if user.numbers.reserved.any? && raffle.waiting_payment? && raffle.multiple?
        buttons[2].push(show_payment_funnel_button(raffle.price,
                                                   user.numbers.count))
      end
      if user.numbers.reserved.any? && raffle.open?
        buttons[2].push(show_reserved_numbers_button)
      end

      buttons
    end

    def create_raffle_button
      Button::Button.generate(t('button.create_raffle'), 'admin_create_raffle')
    end

    def admin_raffle_button
      Button::Button.generate(t('button.admin_raffle'), 'show_admin_numbers_1')
    end

    def verify_payments_button
      Button::Button.generate(t('button.verify_payments'), 'admin_show_verify_payments_1_edit')
    end

    def change_raffle_status_button
      Button::Button.generate(t('button.change_raffle_status'), 'admin_show_raffle_status')
    end

    def edit_raffle_button
      Button::Button.generate(t('button.edit_raffle'), 'admin_edit_raffle')
    end

    def summarize_raffle_button
      Button::Button.generate(t('button.summarize_raffle'), 'admin_show_raffle_summary')
    end

    def show_raffle_button
      Button::Button.generate(t('button.show_raffle'), 'show_raffle_description_edit')
    end

    def available_numbers_button
      Button::Button.generate(t('button.available_numbers'),
                              'show_available_numbers_1')
    end

    def show_raffle_photos
      Button::Button.generate(t('button.show_raffle_photos'), 'show_raffle_photos')
    end

    def show_payment_funnel_button(price, numbers_count)
      Button::Button.generate(
        t('button.show_payment_funnel', total_price: format_price(numbers_count * price), numbers_count:, number_price: format_price(price)), 'show_payment_funnel')
    end

    def show_reserved_numbers_button
      Button::Button.generate(t('button.show_reserved_numbers'),
                              'show_reserved_numbers_1')
    end

    def format_price(cents)
      PriceFormatter.format_price(cents)
    end

    def t(key, options = {})
        I18n.t("show_description.#{key}", **options)
    end

    attr_accessor :raffle, :user, :message_action
  end
end
