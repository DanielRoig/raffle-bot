module Button
  class Back < Button
    def self.generate(text: t('back'), callback_data: 'show_raffle_description_edit')
      new(text, callback_data).result
    end

    def self.t(key, options = {})
      I18n.t("button.#{key}", **options)
    end
  end
end
