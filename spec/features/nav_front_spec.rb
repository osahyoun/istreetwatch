require 'rails_helper'

RSpec.describe 'Front-facing navigation', type: :feature do
  before do
    visit root_path
  end

  describe 'selecting Report Incident' do
    context 'when top-nav btn is clicked' do
      it 'should navigate to report form' do
        expect( page ).to have_current_path( root_path )
        within( '.top-nav' ) do
          click_link( 'Report Incident' )
        end
        expect( page ).to have_current_path( new_report_path )
      end
    end

    context 'when side-nav link is clicked' do
      it 'should navigate to report form' do
        expect( page ).to have_current_path( root_path )
        within( '.side-nav' ) do
          click_link( 'Report Incident' )
        end
        expect( page ).to have_current_path( new_report_path )
      end
    end

    context 'when footer link is clicked' do
      it 'should navigate to report form' do
        expect( page ).to have_current_path( root_path )
        within( '.page-footer' ) do
          click_link( 'Report Incident' )
        end
        expect( page ).to have_current_path( new_report_path )
      end
    end
  end

  describe 'selecting Pledge' do
    context 'when main pledge link is clicked' do
      it 'should navigate to pledge page' do
        expect( page ).to have_current_path( root_path )
        within( '.side-nav' ) do
          click_link( 'Pledge' )
        end
        expect( page ).to have_current_path( new_pledge_path )
      end
    end

    context 'when secondary pledge link is clicked' do
      it 'should navigate to pledge page' do
        expect( page ).to have_current_path( root_path )
        within( '.side-nav' ) do
          click_link( 'Will you?' )
        end
        expect( page ).to have_current_path( new_pledge_path )
      end
    end

    context 'when footer link is clicked' do
      it 'should navigate to pledge page' do
        expect( page ).to have_current_path( root_path )
        within( '.page-footer' ) do
          click_link( 'Pledge' )
        end
        expect( page ).to have_current_path( new_pledge_path )
      end
    end
  end

  describe 'selecting Timeline' do
    context 'when side-nav link is clicked' do
      it 'should navigate to timeline page' do
        expect( page ).to have_current_path( root_path )
        within( '.side-nav' ) do
          click_link( 'Timeline' )
        end
        expect( page ).to have_current_path( timeline_reports_path )
      end
    end

    context 'when footer link is clicked' do
      it 'should navigate to timeline page' do
        expect( page ).to have_current_path( root_path )
        within( '.page-footer' ) do
          click_link( 'Timeline' )
        end
        expect( page ).to have_current_path( timeline_reports_path )
      end
    end
  end

  describe 'selecting About' do
    context 'when side-nav link is clicked' do
      it 'should navigate to about page' do
        expect( page ).to have_current_path( root_path )
        within( '.side-nav' ) do
          click_link( 'About' )
        end
        expect( page ).to have_current_path( about_path )
      end
    end

    context 'when footer link is clicked' do
      it 'should navigate to about page' do
        expect( page ).to have_current_path( root_path )
        within( '.page-footer' ) do
          click_link( 'About' )
        end
        expect( page ).to have_current_path( about_path )
      end
    end
  end

  describe 'selecting Finding Help' do
    context 'when side-nav link is clicked' do
      it 'should navigate to help page' do
        expect( page ).to have_current_path( root_path )
        within( '.side-nav' ) do
          click_link( 'Finding Help' )
        end
        expect( page ).to have_current_path( finding_help_path )
      end
    end

    context 'when footer link is clicked' do
      it 'should navigate to help page' do
        expect( page ).to have_current_path( root_path )
        within( '.page-footer' ) do
          click_link( 'Finding Help' )
        end
        expect( page ).to have_current_path( finding_help_path )
      end
    end
  end

  describe 'clicking on iSW logo' do
    before do
      visit new_report_path
    end

    context 'when side-nav link is clicked' do
      it 'should navigate to home page' do
        expect( page ).to have_current_path( new_report_path )
        within( '.side-nav' ) do
          find( '.logo a' ).click
        end
        expect( page ).to have_current_path( root_path )
      end
    end

    context 'when footer link is clicked' do
      it 'should navigate to home page' do
        expect( page ).to have_current_path( new_report_path )
        within( '.page-footer' ) do
          click_link( 'Home' )
        end
        expect( page ).to have_current_path( root_path )
      end
    end
  end

  describe 'selecting Privacy Policy' do
    it 'should navigate to policy page' do
      expect( page ).to have_current_path( root_path )
      within( '.page-footer' ) do
        click_link( 'Privacy Policy' )
      end
      expect( page ).to have_current_path( privacy_path )
    end
  end
end