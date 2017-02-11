class Admin::ReportsController < ApplicationController
  if Rails.env.production?
    http_basic_authenticate_with name: "admin", password: ENV['PASSWORD']
  end

  before_action :set_report, only: [:show, :edit, :update, :destroy]
  after_action :send_published_email, only: [:update]
  layout 'admin'

  def index
    @reports = Report.q_admin( params[:q], params[:from], params[:to] ).paginate( page: params[:page], per_page: 30 ).records
    @overview_info = unless params[:q].blank?
      "#{@reports.total} reports found"
    else
      "#{Report.approved.count} of #{Report.count} reports have been approved"
    end
  end

  def edit
  end

  def update
    if @report.update(report_params)
      redirect_to [:admin, :reports], notice: "Report ##{@report.id} was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @report.destroy
    redirect_to admin_reports_url, notice: 'Report was successfully destroyed.'
  end

  private
    def set_report
      @report = Report.find(params[:id])
    end

    def send_published_email
      if @report.previous_changes[ :approved_at ]
        ReportMailer.report_published_email( @report ).deliver_now
      end
    end

    def report_params
      params.require(:report).permit(
        :informant_name, :informant_email, :informant_tel, :informant_role,
        :type_incident, :type_incident_other, :description, :support, :date,
        :street, :town, :postcode, :region, :lng, :lat, :house, :country, :type_location, :type_location_other,
        :reported_to_police, :approved
      )
    end
end
