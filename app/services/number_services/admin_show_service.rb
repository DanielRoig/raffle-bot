module NumberServices
    class AdminShowService
        include Service

        def call
            return Message::NotAllowedAction.new(user) unless user.admin?
            return Message::NoActiveRaffle.new(user) unless raffle         

            number = Number.find_by(value:, raffle:)

            Message::Message.new(message(number), [status_buttons(number)].push(back_button), 'text')
        end

        private

        def message(number)
            t('text',
                number: number.formatted_value,
                color_status: I18n.t("number.#{number.status}.color"),
                status: I18n.t("number.#{number.status}.status"),
                telegram_first_name: number.user&.telegram_first_name,
                telegram_username: number.user&.telegram_username
            )
        end

        def status_buttons(number)
            Number.statuses.keys.map do |status|
                { text: "#{I18n.t("number.#{status}.color")} #{I18n.t("number.#{status}.status")}", callback_data: "admin_update_number_status_#{status}_#{number.value}" }
            end        
        end

        def back_button
             [Button::Back.generate(callback_data: 'show_admin_numbers_1')]
        end

        def t(key, options = {})
            I18n.t("admin_show_numbers.#{key}", **options)
        end

        attr_accessor :raffle, :user, :value
    end
end