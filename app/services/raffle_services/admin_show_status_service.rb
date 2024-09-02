module RaffleServices
  class AdminShowStatusService
    include Service

    def call
      return Message::NotAllowedAction.new(user) unless user.admin?
      return Message::NoActiveRaffle.new(user) unless raffle

      Message::Message.new(t('text'), status_buttons.push(back_button), 'text')
    end

    private

    def status_buttons
      Raffle.statuses.keys.map do |status|
        [{ text: I18n.t("raffle.#{status}"),
callback_data: "admin_update_raffle_status_#{status}" }]
      end
    end

    def back_button
      [Button::Back.generate]
    end

    def t(key, options = {})
      I18n.t("admin_show_status.#{key}", **options)
    end

    attr_accessor :raffle, :user
  end
end
