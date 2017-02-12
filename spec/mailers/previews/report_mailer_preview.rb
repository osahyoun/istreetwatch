class ReportMailerPreview < ActionMailer::Preview

  def report_published_email
    ReportMailer.report_published_email( Report.first )
  end

end