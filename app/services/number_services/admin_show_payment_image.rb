module NumberServices
  class AdminShowPaymentImage
    include Service

    def call
      unless current_user.admin?
        return Message::NotAllowedAction.new(current_user)
      end

      return Message::NoActiveRaffle.new(current_user) unless raffle

      if new_status && number_id
        Number.find(number_id).update(status: new_status)
      end

      user = User.find(user_id)
      buttons = user.numbers.map do |number|
        row_buttons(number)
      end .push(back_button)
      unless user.image
        return Message::Message.new(
          t('text',
            telegram_first_name: user.telegram_first_name), buttons, 'text', 'edit'
        )
      end

      image_url = TelegramImagesService.call(images: [user.image]).first

      if new_status && number_id
        return Message::Message.new(
          t('text',
            telegram_first_name: user.telegram_first_name), buttons, 'photo', 'edit_buttons', image_url
        )
      end

      Message::Message.new(
        t('text',
          telegram_first_name: user.telegram_first_name), buttons, 'photo', 'new', image_url
      )
    end

    private

    def row_buttons(number)
      buttons = [Button::Button.generate(
        "[#{number.formatted_value} #{I18n.t("number.#{number.status}.color")}]", 'x'
      )]
      Number.statuses.keys.each do |status|
        buttons.push({
                       text: I18n.t("number.#{status}.color"), callback_data: "admin_show_payment_image_#{user_id}_#{number.id}_#{status}"
                     })
      end
      buttons
    end

    def back_button
      [Button::Back.generate(callback_data: 'admin_show_verify_payments_1_new')]
    end

    def t(key, options = {})
      I18n.t("admin_show_payment_image.#{key}", **options)
    end

    attr_accessor :current_user, :raffle, :user_id, :number_id, :new_status
  end
end
