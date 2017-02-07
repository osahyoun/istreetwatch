require 'rails_helper'

RSpec.describe 'Filling out report', type: :feature do
  before do
    visit new_report_path
  end

  describe 'selecting type of incident', js: true do
    context 'when "other" is not selected' do
      before do
        select('Hate post', from: 'What type of incident was it?')
      end

      it 'should not show type_incident_other field' do
        expect( page ).not_to have_content( /please tell us/i )
      end
    end

    context 'when "other" is selected' do
      before do
        select('Other', from: 'What type of incident was it?')
      end

      it 'should show type_incident_other field' do
        expect( page ).to have_content( /please tell us/i )
      end
    end
  end

  describe 'selecting type of location', js: true do
    context 'when "other" is not selected' do
      before do
        select('Shops', from: 'Type of location:')
      end

      it 'should not show type_location_other field' do
        expect( page ).not_to have_content( /please tell us/i )
      end
    end

    context 'when "other" is selected' do
      before do
        select('Other', from: 'Type of location:')
      end

      it 'should show type_location_other field' do
        expect( page ).to have_content( /please tell us/i )
      end
    end
  end
end