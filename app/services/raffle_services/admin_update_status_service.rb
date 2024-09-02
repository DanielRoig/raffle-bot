module RaffleServices
  class AdminUpdateStatusService
    include Service

    def call
      return Message::NotAllowedAction.new(user) unless user.admin?
      return Message::NoActiveRaffle.new(user) unless raffle

      raffle.update(status: status)
      Message::Message.new(t('text', raffle_status:), buttons, 'text')
    end

    private

    def buttons
      [[Button::Back.generate]]
    end

    def raffle_status
        I18n.t("raffle.#{status}")
    end

    def t(key, options = {})
        I18n.t("admin_update_status.#{key}", **options)
    end

    attr_accessor :user, :status, :raffle
  end
end
