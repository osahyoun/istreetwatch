require "rails_helper"

describe "PUT udpate" do
  context 'when report approved' do
    let(:report) { create(:report) }

    it 'should send report published email once' do
      put admin_report_path( report ), params: {report: {approved: true}}
      expect( ActionMailer::Base.deliveries.count ).to be( 1 )
      expect{
        put admin_report_path( report ), params: {report: {approved: true}}
      }.not_to change{ ActionMailer::Base.deliveries.count }.from( 1 )
    end
  end
end
