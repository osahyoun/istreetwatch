require 'rails_helper'

describe Report do
  let( :report ) { Report.new }

  describe 'validations' do
    it 'should validate presence of informant_name' do
      expect( report ).not_to be_valid
      expect( report.errors[ :informant_name ] ).to include( "can't be blank" )
    end

    it 'should validate presence of informant_email' do
      expect( report ).not_to be_valid
      expect( report.errors[ :informant_email ] ).to include( "can't be blank" )
    end

    it 'should validate presence of informant_role' do
      expect( report ).not_to be_valid
      expect( report.errors[ :informant_role ] ).to include( "can't be blank" )
    end

    it 'should validate presence of type_incident' do
      expect( report ).not_to be_valid
      expect( report.errors[ :type_incident ] ).to include( "can't be blank" )
    end

    context 'when type of incident is not other' do
      before do
        report.type_incident = 'not other'
      end

      it 'should not validate presence of type_incident_other' do
        expect( report ).not_to be_valid
        expect( report.errors[ :type_incident_other ] ).not_to include( "can't be blank" )
      end
    end

    context 'when type of incident is other' do
      before do
        report.type_incident = 'other'
      end

      it 'should validate presence of type_incident_other' do
        expect( report ).not_to be_valid
        expect( report.errors[ :type_incident_other ] ).to include( "can't be blank" )
      end
    end

    it 'should validate presence of description' do
      expect( report ).not_to be_valid
      expect( report.errors[ :description ] ).to include( "can't be blank" )
    end

    it 'should validate presence of support' do
      expect( report ).not_to be_valid
      expect( report.errors[ :support ] ).to include( "can't be blank" )
    end

    it 'should validate presence of date' do
      expect( report ).not_to be_valid
      expect( report.errors[ :date ] ).to include( "can't be blank" )
    end

    it 'should validate date not in the future' do
      report.date = 1.day.from_now
      report.valid?
      expect( report.errors[ :date ] ).to include( "can't be in the future" )
      report.date = Date.today
      report.valid?
      expect( report.errors[ :date ] ).not_to include( "can't be in the future" )
    end

    it 'should validate date format' do
      report.date = "banana"
      report.valid?
      expect( report.errors[ :date ] ).to include( "must be valid" )
      report.date = "16 Feb"
      report.valid?
      expect( report.errors[ :date ] ).not_to include( "must be valid" )
      report.date = "16/02/17"
      report.valid?
      expect( report.errors[ :date ] ).not_to include( "must be valid" )
    end

    it 'should validate presence of town' do
      expect( report ).not_to be_valid
      expect( report.errors[ :town ] ).to include( "can't be blank" )
    end

    it 'should validate presence of type_location' do
      expect( report ).not_to be_valid
      expect( report.errors[ :type_location ] ).to include( "can't be blank" )
    end

    context 'when type of location is not other' do
      before do
        report.type_location = 'not other'
      end

      it 'should not validate presence of type_location_other' do
        expect( report ).not_to be_valid
        expect( report.errors[ :type_location_other ] ).not_to include( "can't be blank" )
      end
    end

    context 'when type of location is other' do
      before do
        report.type_location = 'other'
      end

      it 'should validate presence of type_location_other' do
        expect( report ).not_to be_valid
        expect( report.errors[ :type_location_other ] ).to include( "can't be blank" )
      end
    end

    it 'should validate presence of reported_to_police' do
      expect( report ).not_to be_valid
      expect( report.errors[ :reported_to_police ] ).to include( "can't be blank" )
    end
  end

  describe 'scopes' do
    describe '.approved' do
      let!( :approved_report ) { create( :report, approved: true ) }
      let!( :unapproved_report ) { create( :report, approved: false ) }

      it 'should return approved reports' do
        expect( Report.count ).to eql( 2 )
        expect( Report.approved.count ).to eql( 1 )
        expect( Report.approved.first ).to eql( approved_report )
      end
    end
  end

  describe 'hooks' do
    describe ':check_lat_lng' do
      let!( :exisiting_report ) { create( :report, lng: 1.0, lat: 1.0 ) }

      it 'should change coords if location taken' do
        new_report = create( :report, lng: 1.0, lat: 1.0 )
        expect( new_report.lat ).not_to eql( exisiting_report.lat )
        expect( new_report.lng ).not_to eql( exisiting_report.lng )
      end
    end

    describe ':set_approved_at' do
      it 'should not set approved_at date if report not approved' do
        report = create( :report, approved: false )
        expect( report.approved_at ).to eql( nil )
      end

      it 'should set approved_at date if report approved' do
        report = create( :report, approved: true )
        expect( report.approved_at ).not_to eql( nil )
      end
    end
  end

  describe 'class methods' do
    describe '.latest' do
      let!( :new_report ) { create( :report, approved: true, date: Time.zone.now ) }
      let!( :old_report ) { create( :report, approved: true, date: 1.day.ago ) }

      it 'should return approved reports in desc order' do
        expect( Report.latest.count ).to eql( 2 )
        expect( Report.latest.first ).to eql( new_report )
        expect( Report.latest.last ).to eql( old_report )
      end
    end

    describe '.latest_for_map' do
      let!( :new_report_with_coords ) { create( :report, approved: true, date: Time.zone.now, lat: 50 ) }
      let!( :old_report_with_coords ) { create( :report, approved: true, date: 1.day.ago, lat: 50 ) }
      let!( :no_coords_report ) { create( :report, approved: true, date: 1.day.ago, lat: nil ) }

      it 'should return approved reports that have lat lng coordinates in desc order' do
        expect( Report.latest_for_map.count ).to eql( 2 )
        expect( Report.latest_for_map.first ).to eql( new_report_with_coords )
        expect( Report.latest_for_map.last ).to eql( old_report_with_coords )
      end
    end
  end
end