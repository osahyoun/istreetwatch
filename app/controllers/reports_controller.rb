class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @report = Report.new
  end

  def sent
  end

  def timeline
    @reports = unless params[:q].blank?
      Report.q_public( params[:q] ).page( params[:page] ).records
    else
      Report.latest.paginate(page: params[:page])
    end
  end

  def create
    @report = Report.new(report_params)

    respond_to do |format|
      if @report.save
        format.html { render :sent }
      else
        format.html { render :new }
      end
    end
  end

  private
    def set_report
      @report = Report.find(params[:id])
    end

    def report_params
      params.require(:report).permit(
        :informant_name, :informant_email, :informant_tel, :informant_role, :informant_permission,
        :type_incident, :type_incident_other, :description, :support, :date,
        :street, :town, :postcode, :region, :lng, :lat, :house, :country, :type_location, :type_location_other,
        :reported_to_police
      )
    end
end
