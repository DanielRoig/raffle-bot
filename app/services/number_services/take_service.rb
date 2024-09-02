module NumberServices
    class TakeService
        include Service

        def call
            return Message::NoActiveRaffle.new(user) unless raffle        
            number = Number.find_by(value:, raffle:)
            return not_allowed_take_number_message unless number.user.nil? && raffle.open?
            return already_reserved_number_message if already_reserved_number?
            number.update(user: user, status: :reserved)
            take_number_message
        end

        private

        def take_number_message
            Message::Message.new(t('take_number', value:), back_button, 'text')
        end

        def not_allowed_take_number_message
            Message::Message.new(t('not_allowed_take_number', value:), back_button, 'text')
        end

        def already_reserved_number?
            raffle.single? && user.numbers.where(raffle:).exists?
        end

        def already_reserved_number_message
            Message::Message.new(t('already_reserved_number'), back_button, 'text')
        end

        def back_button
            [[Button::Back.generate]]
        end

        def t(key, options = {})
            I18n.t("take_number.#{key}", **options)
        end

        attr_accessor :raffle, :user, :value
    end
end