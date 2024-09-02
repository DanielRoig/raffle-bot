module NumberServices
  class AdminUpdateStatusService
    include Service

    def call
        return Message::NotAllowedAction.new(user) unless user.admin?
        return Message::NoActiveRaffle.new(user) unless raffle         
        number = Number.find_by(value:, raffle: raffle)
        return number_not_found_message unless number

        number.update(status: status)
        number_updated_message
    end

    private

    def number_not_found_message
      Message::Message.new(t('number_not_found'), back_button, 'text')
    end

    def number_updated_message  
      Message::Message.new(t('number_updated', value:), back_button, 'text')
    end

    def back_button
      [[Button::Back.generate(callback_data: 'show_admin_numbers_1')]]
    end

    def t(key, options = {})
      I18n.t("update_status_number.#{key}", **options)
    end

    attr_accessor :value, :status, :raffle, :user
  end
end