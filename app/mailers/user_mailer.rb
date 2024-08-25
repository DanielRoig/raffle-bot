class UserMailer < ApplicationMailer
  def welcome_email(email)
    mail(to: email, subject: 'Welcome')
  end
end
