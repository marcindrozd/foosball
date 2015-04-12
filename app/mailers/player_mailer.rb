class PlayerMailer < ApplicationMailer
  def send_challenge(sender, recipient, message)
    @sender = sender
    @recipient = recipient
    @message = message

    mail from: @sender.email, to: @recipient.email, subject: "You have been challenged!"
  end
end
