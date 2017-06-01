class ReportMailer < ApplicationMailer
  default from: 'istreetwatch@migrantsrights.org.uk'

  def verification_email( report )
    @name = report.informant_name
    @url  = verify_email_url( code: report.verification_code )
    @report_text = report.description
    mail(to: report.informant_email, subject: 'Please confirm your email address')
  end

  def report_published_email( report )
    @name = report.informant_name
    @url  = report_url( report )
    mail(to: report.informant_email, subject: 'Your report has been published')
  end
end
