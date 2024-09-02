module NumberServices
    class ShowGridService
        include Service

        NUMBERS_PER_PAGE = 50
        COLUMNS = 5

        def call
            return Message::NoActiveRaffle.new(user) unless raffle 

            types = {
                'available' => -> { show_available_numbers_gird},
                'reserved' => -> { show_reserved_numbers_grid},
                'admin' => -> { admin_show_numbers_grid}
            }

            types[type].call
        end

        private

        def admin_show_numbers_grid
            numbers = raffle.numbers.sort_by(&:value)
            button_grid = button_grid(numbers, 'admin_numbers', true)
            Message::Message.new(t('choose_number'), button_grid, 'text')
        end
        
        def show_available_numbers_gird
            numbers = raffle.numbers.available.sort_by(&:value)
            message = numbers.empty? ? t('not_available_number') : t('choose_number')
            button_grid = button_grid(numbers, 'available_numbers')
            Message::Message.new(message, button_grid, 'text')
        end
    
        def show_reserved_numbers_grid
            numbers = raffle.numbers.where(user:).sort_by(&:value)
            message = numbers.empty? ? t('not_reserved_number') : t('choose_number')
            button_grid = button_grid(numbers, 'reserved_numbers')
            Message::Message.new(message, button_grid, 'text')
        end

        def button_grid(numbers, callback_prefix, with_status = false)
            buttons_grid = paged_numbers(numbers).each_slice(COLUMNS).map do |row|
              row.map { |number| generate_number_button(number, with_status, callback_prefix) }
            end

            previous_page_button = generate_previous_page_button(callback_prefix)
            next_page_button = generate_next_page_button(callback_prefix, numbers)
        
            buttons_grid += [[previous_page_button, next_page_button].compact] if next_page_button || previous_page_button
            buttons_grid += back_button
        end

        def paged_numbers(numbers)
            numbers.drop((page - 1) * NUMBERS_PER_PAGE).take(NUMBERS_PER_PAGE)
        end

        def generate_number_button(number, with_status, callback_prefix)
            text = number.formatted_value
            text ="#{I18n.t("number.#{number.status}.color")} #{text}" if with_status

            Button::Button.generate(text, "#{callback_prefix}_#{number.value}")
        end

        def generate_previous_page_button(callback_prefix)
            Button::Button.generate('<<', "show_#{callback_prefix}_#{page - 1}") if page > 1
        end

        def generate_next_page_button(callback_prefix, numbers)
            Button::Button.generate('>>', "show_#{callback_prefix}_#{page + 1}") if numbers.count > page * NUMBERS_PER_PAGE
        end

        def back_button
            [[Button::Back.generate]]
        end

        def t(key, options = {})
            I18n.t("show_grid.#{key}", **options)
        end

        attr_accessor :raffle, :type, :page, :user
    end
end