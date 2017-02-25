require 'rails_helper'

RSpec.describe 'Filling out report', type: :feature do
  before do
    visit new_report_path
  end

  describe 'selecting type of incident', js: true do
    context 'when "other" is not selected' do
      before do
        select('Verbal abuse / insults', from: 'What type of incident was it?', visible: false)
      end

      it 'should not show type_incident_other field' do
        expect( page ).not_to have_content( /please tell us/i )
      end
    end

    context 'when "other" is selected' do
      before do
        select('Other', from: 'What type of incident was it?', visible: false)
      end

      it 'should show type_incident_other field' do
        expect( page ).to have_content( /please tell us/i )
      end
    end
  end

  describe 'selecting type of location', js: true do
    context 'when "other" is not selected' do
      before do
        select('Shops', from: 'Type of location:', visible: false)
      end

      it 'should not show type_location_other field' do
        expect( page ).not_to have_content( /please tell us/i )
      end
    end

    context 'when "other" is selected' do
      before do
        select('Other', from: 'Type of location:', visible: false)
      end

      it 'should show type_location_other field' do
        expect( page ).to have_content( /please tell us/i )
      end
    end
  end

  describe 'submitting report', js: true do
    before do
      fill_in 'Name or Initials', with: 'name'
      fill_in 'Email', with: 'test@email'
      select('Something that happened to me', from: 'This incident was', visible: false)
      select('Other', from: 'What type of incident was it?', visible: false)
      fill_in 'Please tell us', with: 'other'
      fill_in 'Tell us what happened', with: 'description'
      fill_in 'Tell us if anyone spoke up, or offered support', with: 'support'
      within( '.input-field.date' ) do
        select( '3', from: 'report_date_3i', visible: false )
        select( 'Nov', from: 'report_date_2i', visible: false )
        select( '2016', from: 'report_date_1i', visible: false )
      end
      select('Shops', from: 'Type of location', visible: false)
      select('No', from: 'Has this incident been reported to the police?', visible: false)
      click_button( 'Create Report' )
    end

    it 'should show any errors' do
      expect( page ).to have_content( /1 error stopped this from being saved/i )
      expect( page ).to have_content( /town can't be blank/i )
    end

    it 'should successfully submit form if no errors' do
      fill_in 'Town', with: 'Brighton'
      click_button( 'Create Report' )
      expect( page ).to have_content( /thank you/i )
    end
  end
end