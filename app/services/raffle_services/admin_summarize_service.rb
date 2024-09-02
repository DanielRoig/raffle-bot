module RaffleServices
  class AdminSummarizeService
    include Service

    def call
      return Message::NotAllowedAction.new(user) unless user.admin?
      return Message::NoActiveRaffle.new(user) unless raffle

      numbers = raffle.numbers.sort_by(&:value)
      Message::Message.new(message(numbers), back_button, 'text')
    end

    private

    def message(numbers)
      numbers.map { |number| format_number_text(number) }.join("\n")
    end

    def format_number_text(number)
      status = I18n.t("number.#{number.status}.color")
      value = number.formatted_value
      first_name = number.user&.telegram_first_name
      username = number.user&.telegram_username

      formatted_text = "#{status} - #{value}"
      formatted_text += " - #{first_name}" if first_name.present?
      formatted_text += " - @#{username}" if username.present?
      formatted_text
    end

    def back_button
      [[Button::Back.generate]]
    end

    attr_accessor :raffle, :user
  end
end
