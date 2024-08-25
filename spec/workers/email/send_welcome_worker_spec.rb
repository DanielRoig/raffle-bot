require 'rails_helper'

RSpec.describe Email::SendWelcomeWorker, type: :job do
  subject { described_class.new }

  describe '#perform' do
    let(:result) { subject.perform(email) }

    let(:email) { 'example@example.com' }

    it 'call UserMailer to send an email' do
      message_delivery = instance_double(ActionMailer::MessageDelivery)
      expect(UserMailer).to receive(:welcome_email).with(email).and_return(message_delivery)
      allow(message_delivery).to receive(:deliver_now)

      result
    end
  end
end
