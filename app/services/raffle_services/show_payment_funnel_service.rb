module RaffleServices
  class ShowPaymentFunnelService
    include Service

    def call
      return Message::NoActiveRaffle.new(user) unless raffle
      return not_allow_pay_message unless raffle.waiting_payment?

      session[:uploading_payment_image] = true

      return already_uploaded_image_message unless user.image.nil?

      Message::Message.new(
        t('send_image_payment'), [], 'text', 'new'
      )
    end

    private

    def back_button
      [[Button::Back.generate]]
    end

    def already_uploaded_image_message
      Message::Message.new(t('already_upladed_image'),
                           back_button, 'text', 'new')
    end

    def not_allow_pay_message
      Message::Message.new(t('not_allowed_pay'), back_button, 'text')
    end

    def t(key, options = {})
      I18n.t("show_payment_funnel.#{key}", **options)
    end

    attr_accessor :raffle, :user, :session
  end
end
