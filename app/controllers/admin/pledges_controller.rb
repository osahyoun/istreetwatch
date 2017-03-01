class Admin::PledgesController < Admin::AdminController

  def index
    dates = DatePicker.calc_to_and_from_dates(
      tDate: DatePicker.s_to_date( params[:to] ),
      fDate: DatePicker.s_to_date( params[:from] ),
      fDate_default: Pledge.first.created_at
    )

    @tDate = dates[:tDate]
    @fDate = dates[:fDate]

    pledges = Pledge.
      where( created_at: (@fDate..@tDate) ).
      order( "created_at desc" )

    respond_to do |format|
      format.html do
        @pledges = pledges.paginate( page: params[:page], per_page: 30 )
      end
      format.csv { send_data Pledge.to_csv( pledges ) }
    end
  end

end
