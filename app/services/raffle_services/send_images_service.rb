module RaffleServices
  class SendImagesService
    include Service

    def call
      return Message::NoActiveRaffle.new(user) unless raffle

      if raffle.images.empty?
        return Message::Message.new(t('no_images'), back_button,
                                    'text')
      end

      TelegramImagesService.call(images: raffle.images).map.with_index do |image_url, index|
        button = index == raffle.images.size - 1 ? back_button : []

        Message::Message.new(nil, button, 'photo', 'new', image_url)
      end
    end

    private

    def message
      'No hay fotos en esta rifa'
    end

    def back_button
      [[Button::Back.generate(callback_data: 'show_raffle_description_new')]]
    end

    def t(key, options = {})
      I18n.t("send_images.#{key}", **options)
    end

    attr_accessor :raffle, :user, :controller
  end
end
