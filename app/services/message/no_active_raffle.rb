module Message
  class NoActiveRaffle < Message
    def initialize(user)
      if user.admin?
        buttons = [
          [
            { text: t('create_button'),
              callback_data: 'admin_create_raffle' }
          ]
        ]
      end
      super(t('text'), buttons, 'text', 'new')
    end

    private

    def t(key, options = {})
      I18n.t("message.no_active_raffle.#{key}", **options)
    end
  end
end
