module Email
  class SendWelcomeWorker
    include Sidekiq::Worker

    def perform(email)
      UserMailer.welcome_email(email).deliver_now
    end
  end
end
