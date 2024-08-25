class ApplicationMailer < ActionMailer::Base
  default from: ENV['RAILS_API_BOILERPLATE_EMAIL']
  layout 'mailer'
end
