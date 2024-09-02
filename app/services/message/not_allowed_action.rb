module Message
  class NotAllowedAction < Message
    def initialize(_user)
      super(t('text'), [[Button::Back.generate]], 'text', 'new')
    end

    private

    def t(key, options = {})
      I18n.t("message.not_allowed_action.#{key}", **options)
    end
  end
end
