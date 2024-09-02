module NumberServices
  class AdminShowUsersService
    include Service

    USERS_PER_PAGE = 50

    def call
      unless current_user.admin?
        return Message::NotAllowedAction.new(current_user)
      end
      return Message::NoActiveRaffle.new(current_user) unless raffle

      users = User.with_numbers
      buttons = paged_users(users).map { |user| user_button(user) }

      previous_page_button = generate_previous_page_button
      next_page_button = generate_next_page_button(users)
      if next_page_button || previous_page_button
        buttons += [[previous_page_button,
                     next_page_button].compact]
      end

      buttons << back_button

      Message::Message.new(t('text'), buttons, 'text', message_action)
    end

    private

    def paged_users(users)
      users.drop((page - 1) * USERS_PER_PAGE).take(USERS_PER_PAGE)
    end

    def generate_previous_page_button
      if page > 1
        Button::Button.generate('<<',
                                "admin_show_verify_payments_#{page - 1}_#{message_action}")
      end
    end

    def generate_next_page_button(users)
      if users.count > page * USERS_PER_PAGE
        Button::Button.generate('>>',
                                "admin_show_verify_payments_#{page + 1}_#{message_action}")
      end
    end

    def user_button(user)
      [Button::Button.generate(
        "#{user.telegram_first_name}#{user_numbers(user)}", "admin_show_payment_image_#{user.id}"
      )]
    end

    def user_numbers(user)
      user.numbers.map do |number|
        "[#{number.formatted_value} #{I18n.t("number.#{number.status}.color")}]"
      end.join(' ')
    end

    def back_button
      [Button::Back.generate]
    end

    def t(key, options = {})
      I18n.t("admin_show_users_numbers.#{key}", **options)
    end

    attr_accessor :raffle, :current_user, :message_action, :page
  end
end
