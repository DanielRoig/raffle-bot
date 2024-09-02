module RaffleServices
  class AdminEditService
    ESCAPE_WORD = 'skip'.freeze

    def initialize(session: nil, message: nil, user: nil, raffle: nil)
      @session = session
      @message = message
      @user = user
      @raffle = raffle
    end

    def start_edit
      return Message::NotAllowedAction.new(user) unless user.admin?

      session[:editing_raffle] = true
      session[:raffle_data] = {
        name: raffle.name,
        description: raffle.description,
        price: raffle.price,
        payment_info: raffle.payment_info
      }
      ask_raffle_name
    end

    def process_response
      return Message::NotAllowedAction.new(user) unless user.admin?

      case session[:raffle_step]
      when :name
        session[:raffle_data][:name] = message['text'] unless skip_field?
        ask_raffle_description
      when :description
        session[:raffle_data][:description] = message['text'] unless skip_field?
        ask_raffle_price
      when :price
        session[:raffle_data][:price] = message['text'] unless skip_field?
        ask_raffle_payment_info
      when :payment_info
        unless skip_field?
          session[:raffle_data][:payment_info] =
            message['text']
        end
        finalize_creation
      end
    end

    def clear_session
      session.delete(:editing_raffle)
      session.delete(:raffle_data)
      session.delete(:raffle_step)
    end

    private

    def skip_field?
      message['text'].strip.casecmp('skip').zero?
    end

    def ask_raffle_name
      session[:raffle_step] = :name
      Message::Message.new(
        t('ask_raffle_name', raffle_name: raffle.name,
escape_word: ESCAPE_WORD), [], 'text', 'new'
      )
    end

    def ask_raffle_description
      session[:raffle_step] = :description
      Message::Message.new(
        t('ask_raffle_description', raffle_description: raffle.description,
escape_word: ESCAPE_WORD), [], 'text', 'new'
      )
    end

    def ask_raffle_price
      session[:raffle_step] = :price
      Message::Message.new(
        t('ask_raffle_price', raffle_price: format_price(raffle.price),
escape_word: ESCAPE_WORD), [], 'text', 'new'
      )
    end

    def ask_raffle_payment_info
      session[:raffle_step] = :payment_info
      Message::Message.new(
        t('ask_raffle_payment_info', raffle_payment_info: raffle.payment_info,
escape_word: ESCAPE_WORD), [], 'text', 'new'
      )
    end

    def finalize_creation
      raffle = Raffle.first
      raffle.update(
        name: session[:raffle_data][:name],
        description: session[:raffle_data][:description],
        price: session[:raffle_data][:price],
        payment_info: session[:raffle_data][:payment_info]
      )

      clear_session
      Message::Message.new(
        t('success_raffle_edited',
          raffle_name: raffle.name), back_button, 'text', 'new'
      )
    end

    def format_price(cents)
      PriceFormatter.format_price(cents)
    end

    def back_button
      [[Button::Back.generate]]
    end

    def t(key, options = {})
      I18n.t("admin_edit.#{key}", **options)
    end

    attr_reader :session, :message, :user, :raffle
  end
end
