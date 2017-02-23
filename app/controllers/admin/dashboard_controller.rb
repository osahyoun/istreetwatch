class Admin::DashboardController < Admin::AdminController

  def index
    c = Chart.new( fDate: params[:from], tDate: params[:to] )
    @data_incident_count_over_time = c.incident_count_over_time
    @unit = c.get_time_unit
  end

  def guide
  end

end