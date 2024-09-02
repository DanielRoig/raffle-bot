module RaffleServices
  class AdminDeleteService
    include Service

    def call
      return Message::NotAllowedAction.new(user) unless user.admin?
      return Message::NoActiveRaffle.new(user) unless raffle

      raffle.destroy
      User.destroy_all
      Message::Message.new(t('text'), back_button, 'text', 'new')
    end

    private

    def back_button
      [[Button::Back.generate]]
    end

    def t(key, options = {})
      I18n.t("admin_delete.#{key}", **options)
    end

    attr_accessor :raffle, :user
  end
end
