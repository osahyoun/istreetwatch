class Admin::DashboardController < Admin::AdminController

  def index
    dates = DatePicker.calc_to_and_from_dates(
      tDate: DatePicker.s_to_date( params[:to] ),
      fDate: DatePicker.s_to_date( params[:from] )
    )

    @tDate = dates[:tDate]
    @fDate = dates[:fDate]

    c = Chart.new( fDate: @fDate, tDate: @tDate )
    @data_incident_count_over_time = c.incident_count_over_time
    @unit = c.get_time_unit
  end

  def guide
  end

end