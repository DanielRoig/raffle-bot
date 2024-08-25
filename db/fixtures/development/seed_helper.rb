module SeedHelper
    CONFIG = Rails.application.config_for(:seeds, env: Rails.env).freeze

    class << self
        def authors_to_create
           CONFIG.dig(:authors, :count) 
        end
        def books_to_create
            CONFIG.dig(:books, :count) 
        end
        def users_to_create
            CONFIG.dig(:users, :count) 
         end
         def books_to_create
             CONFIG.dig(:books, :count) 
         end
        def predictable_email(identifier, role:)
            "#{role}_#{identifier}@test.test"
        end
    end
end