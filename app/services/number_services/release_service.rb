module NumberServices
    class ReleaseService
        include Service

        def call
            return Message::NoActiveRaffle.new(user) unless raffle     
            number = Number.find_by(value:, raffle:)

            return not_allow_release_number_message unless (number.user == user || number.user.admin?) && raffle.open?

            number.update(user: nil, status: :available)
            release_number_message
        end

        private

        def back_button
            [[Button::Back.generate]]
        end

        def not_allow_release_number_message
            Message::Message.new(t('not_allow_release_number', value:), back_button, 'text')
        end

        def release_number_message
            Message::Message.new(t('release_number', value:), back_button, 'text')
        end

        def t(key, options = {})
            I18n.t("release_number.#{key}", **options)
        end

        attr_accessor :raffle, :user, :value
    end
end