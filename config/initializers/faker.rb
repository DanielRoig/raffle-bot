if Rails.env.test? || Rails.env.development?
    require 'faker'
  
    Faker::Config.locale = 'es'
end