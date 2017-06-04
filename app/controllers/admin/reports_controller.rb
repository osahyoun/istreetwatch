class Admin::ReportsController < Admin::AdminController
  before_action :set_report, only: [:show, :edit, :update, :destroy]
  after_action :send_published_email, only: [:update]

  def index
    reports = Report.q_admin(
      q: params[:q],
      fDate: params[:from],
      tDate: params[:to],
      approved_only: params[:approved_only] == '1'
    )

    respond_to do |format|
      format.html do
        @reports = reports.paginate( page: params[:page], per_page: 30 ).records
      end
      format.csv { send_data Report.to_csv( reports.paginate( page: 0, per_page: Report.count ).records ) }
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
      if @report.previous_changes[ :approved ]
        ReportMailer.report_published_email( @report ).deliver_now
      end
    end

    def report_params
      params.require(:report).permit(
        :informant_name, :informant_email, :informant_tel, :informant_role,
        {type_incident: []}, :type_incident_other, :description, :support, :date,
        :street, :town, :postcode, :region, :lng, :lat, :house, :country, :type_location, :type_location_other,
        :reported_to_police, :approved
      )
    end
end
