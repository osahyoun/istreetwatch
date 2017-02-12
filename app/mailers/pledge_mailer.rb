class PledgeMailer < ApplicationMailer
  default from: 'istreetwatch@migrantsrights.org.uk'

  def thank_you_email( pledge )
    @name = pledge.name
    mail(to: pledge.email, subject: "Thank you!")
  end
end
