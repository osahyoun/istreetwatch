class PledgeMailer < ApplicationMailer
  default from: "info@bitsalad.co"

  def thank_you_email( pledge )
    @name = pledge.name
    mail(to: pledge.email, subject: "Thank you!")
  end
end
