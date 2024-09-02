module RaffleServices
  class UploadPaymentImageService
    include Service

    def call
      return unless message['photo']

      image = user.image
      image ? update_image(image) : create_image

      update_numbers_status

      clear_session
      Message::Message.new(t('text'), back_button, 'text', 'new')
    end

    def clear_session
      session.delete(:uploading_payment_image)
    end

    private

    def back_button
      [[Button::Back.generate]]
    end

    def update_numbers_status
      user.numbers.reserved.each(&:pending_approval!)
    end

    def update_image(image)
      image.update(telegram_id: message['photo'].last['file_id'])
    end

    def create_image
      user.create_image(telegram_id: message['photo'].last['file_id'])
    end

    def t(key, options = {})
      I18n.t("upload_payment_image.#{key}", **options)
    end

    attr_accessor :user, :session, :message
  end
end
