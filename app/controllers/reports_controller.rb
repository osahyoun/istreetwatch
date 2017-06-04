class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]
  before_action :allow_iframe, only: [:new, :create, :sent]
  skip_before_action :verify_authenticity_token

  def show
  end

  def new
    @report = Report.new
    if params[:partners].present?
      render 'new', layout: 'layouts/iframe'
    end
  end

  def sent
  end

  def verify
    return if params[:code].blank?
    @report = Report.find_by( verification_code: params[:code] )
    @report.set_verified_at if @report
  end

  def timeline
    @reports = Report.q_public( params[:q] ).paginate( page: params[:page], per_page: 30 ).records
  end

  def create
    @report = Report.new(report_params)
    layout = params[:partners].present? ? 'layouts/iframe' : 'layouts/application'

    if @report.save
      @report.is_from_isw ? @report.remove_verification_code : ReportMailer.verification_email( @report ).deliver_now
      render :sent, layout: layout
    else
      render :new, layout: layout
    end
  end

  private
    def set_report
      @report = Report.find(params[:id])
    end

    def allow_iframe
      if params[:partners].present?
        response.headers.delete "X-Frame-Options"
      end
    end

    def report_params
      params.require(:report).permit(
        :informant_name, :informant_email, :informant_tel, :informant_role, :informant_permission, :informant_is_student,
        {type_incident: []}, :type_incident_other, :description, :support, :date,
        :street, :town, :postcode, :region, :lng, :lat, :house, :country, :type_location, :type_location_other,
        :reported_to_police,
        :source
      )
    end
end
