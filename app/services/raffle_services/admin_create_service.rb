module RaffleServices
  class AdminCreateService
    ESCAPE_WORD = 'skip'.freeze

    def initialize(session: nil, message: nil, user: nil)
      @session = session
      @message = message
      @user = user
    end

    def start_creation
      return Message::NotAllowedAction.new(user) unless user.admin?

      session[:creating_raffle] = true
      session[:raffle_data] = {}
      ask_raffle_name
    end

    def process_response
      return Message::NotAllowedAction.new(user) unless user.admin?

      case session[:raffle_step]
      when :name
        session[:raffle_data][:name] = message['text']
        ask_raffle_description
      when :description
        session[:raffle_data][:description] = message['text']
        ask_raffle_first_number
      when :first_number
        session[:raffle_data][:first_number] = message['text']
        ask_raffle_last_number
      when :last_number
        session[:raffle_data][:last_number] = message['text']
        ask_raffle_price
      when :price
        session[:raffle_data][:price] = message['text']
        ask_raffle_payment_info
      when :payment_info
        session[:raffle_data][:payment_info] = message['text']
        ask_raffle_category
      when :category
        session[:raffle_data][:category] = message['text']
        ask_raffle_images
      when :images
        handle_image_attachment
      end
    end

    def clear_session
      session.delete(:creating_raffle)
      session.delete(:raffle_data)
      session.delete(:raffle_step)
    end

    private

    def ask_raffle_name
      session[:raffle_step] = :name
      Message::Message.new(t('ask_raffle_name'), [], 'text')
    end

    def ask_raffle_description
      session[:raffle_step] = :description
      Message::Message.new(t('ask_raffle_description'), [], 'text')
    end

    def ask_raffle_first_number
      session[:raffle_step] = :first_number
      Message::Message.new(t('ask_raffle_first_number'), [], 'text')
    end

    def ask_raffle_last_number
      session[:raffle_step] = :last_number
      Message::Message.new(t('ask_raffle_last_number'), [], 'text')
    end

    def ask_raffle_price
      session[:raffle_step] = :price
      Message::Message.new(t('ask_raffle_price'), [], 'text')
    end

    def ask_raffle_payment_info
      session[:raffle_step] = :payment_info
      Message::Message.new(t('ask_raffle_payment_info'), [], 'text')
    end

    def ask_raffle_category
      session[:raffle_step] = :category
      Message::Message.new(t('ask_raffle_category'), [], 'text')
    end

    def ask_raffle_images
      session[:raffle_step] = :images
      Message::Message.new(t('ask_raffle_images', escape_word: ESCAPE_WORD),
                           [], 'text')
    end

    def handle_image_attachment
      if message['photo']
        session[:raffle_data][:telegram_image_ids] ||= []
        session[:raffle_data][:telegram_image_ids] << message['photo'].last['file_id']
        Message::Message.new(t('received_image', escape_word: ESCAPE_WORD), [],
                             'text')

      elsif message['text'].downcase == ESCAPE_WORD
        finalize_creation
      else
        Message::Message.new(
          t('error_receiving_image', escape_word: ESCAPE_WORD), [], 'text'
        )
      end
    end

    def finalize_creation
      raffle = Raffle.create(
        name: session[:raffle_data][:name],
        description: session[:raffle_data][:description],
        first_number: session[:raffle_data][:first_number],
        last_number: session[:raffle_data][:last_number],
        price: session[:raffle_data][:price],
        payment_info: session[:raffle_data][:payment_info],
        category: Raffle.categories[session[:raffle_data][:category]]
      )

      attach_images_to_raffle(raffle)

      clear_session
      Message::Message.new(
        t('success_raffle_created',
          raffle_name: raffle.name), back_button, 'text'
      )
    end

    def attach_images_to_raffle(raffle)
      return unless session[:raffle_data][:telegram_image_ids]

      session[:raffle_data][:telegram_image_ids].each do |telegram_image_id|
        raffle.images.create(telegram_id: telegram_image_id)
      end
    end

    def back_button
      [[Button::Back.generate]]
    end

    def t(key, options = {})
      I18n.t("admin_create.#{key}", **options)
    end

    attr_reader :session, :message, :user
  end
end
