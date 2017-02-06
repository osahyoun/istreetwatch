class ReportMailer < ApplicationMailer
  default from: "iStreetWatch@migrantsrights.org.uk"

  def report_published_email( report )
    @name = report.informant_name
    @url  = report_url( report )
    mail(to: report.informant_email, subject: 'Your report has been published')
  end
end
