class Admin::ReportsController < ApplicationController
  if Rails.env.production?
    http_basic_authenticate_with name: "admin", password: ENV['PASSWORD']
  end

  before_action :set_report, only: [:show, :edit, :update, :destroy]
  layout 'admin'

  def index
    @reports = Report.all
    render :index
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to [:admin, :reports], notice: 'Report was successfully updated.' }
        format.json { render :show, status: :ok, location: @report }
      else
        format.html { render :edit }
        format.json { render json: @report.errors, status: :unprocessable_entity }
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

    def report_params
      params.require(:report).permit(:lat, :lng, :time, :address, :description, :summary, :approved, :town, :postcode, :region, :country, :house, :street, :name )
    end
end
