require "rails_helper"

describe "POST create" do
  context 'when report is_from_isw' do
    it "should remove_verification_code" do
      post reports_path( report: attributes_for(:report).merge({ informant_email: 'email@migrantsrights.org.uk'}) )
      post reports_path( report: attributes_for(:report) )

      report_from_isw = Report.first
      report_from_other = Report.last

      expect( report_from_isw.verification_code ).to be( nil )
      expect( report_from_other.verification_code ).to be_instance_of( String )
    end
  end
end
