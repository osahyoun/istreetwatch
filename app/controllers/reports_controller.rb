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
  end

  def create
    @report = Report.new(report_params)

    respond_to do |format|
      if @report.save
        format.html { redirect_to report_sent_path }
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
      params.require(:report).permit(:lat, :lng, :time, :address, :description, :summary, :approved, :town, :postcode, :region, :country, :house, :street, :name, :support )
    end
end
