require 'rails_helper'

RSpec.describe 'Admin report form', type: :feature do
  let!( :report ) { create( :report ) }

  before do
    visit edit_admin_report_path( report )
  end

  describe 'selecting type of incident', js: true do
    context 'when "other" is not selected' do
      it 'should not show type_incident_other field' do
        expect( report ).to be_valid
        expect( page ).not_to have_content( /other type of incident/i )
      end
    end

    context 'when "other" is selected' do
      before do
        find('div.select-wrapper.type-incident input').click #open the dropdown
        find('div.select-wrapper.type-incident li', text: 'Other').click #select other
      end

      it 'should show other field' do
        expect( page ).to have_content( /other type of incident/i )
      end
    end
  end

  describe 'selecting type of location', js: true do
    context 'when "other" is not selected' do
      it 'should not show type_location_other field' do
        expect( report ).to be_valid
        expect( page ).not_to have_content( /other type of location/i )
      end
    end

    context 'when "other" is selected' do
      before do
        find('div.select-wrapper.type-location input').click #open the dropdown
        find('div.select-wrapper.type-location li', text: 'Other').click #select other
      end

      it 'should show type_location_other field' do
        expect( page ).to have_content( /other type of location/i )
      end
    end
  end

  describe 'pressing update btn' do
    before do
      check('Approved for publication on iStreetWatch')
      click_button( 'Save Changes' )
    end

    it 'updates the report' do
      expect( page ).to have_content( /successfully updated/i )
    end

  end
end