class PledgeMailer < ApplicationMailer
  default from: "info@bitsalad.co"

  def thank_you_email( pledge )
    @name = pedge.name
    mail(to: pedge.email, subject: "Thank you!")
  end
end
