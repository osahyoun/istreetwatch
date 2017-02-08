class Admin::ReportsController < ApplicationController
  if Rails.env.production?
    http_basic_authenticate_with name: "admin", password: ENV['PASSWORD']
  end

  before_action :set_report, only: [:show, :edit, :update, :destroy]
  after_action :send_published_email, only: [:update]
  layout 'admin'

  def index
    @reports = Report.order('created_at desc').paginate(page: params[:page], per_page: 50)
    render :index
  end

  def edit
  end

  def update
    respond_to do |format|
      if @report.update(report_params)
        REDIS.set("reports:counter", Report.approved.count)
        format.html { redirect_to [:admin, :reports], notice: 'Report was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @report.destroy
    respond_to do |format|
      format.html { redirect_to admin_reports_url, notice: 'Report was successfully destroyed.' }
      format.json { head :no_content }
    end
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
        :reported_to_police
      )
    end
end
