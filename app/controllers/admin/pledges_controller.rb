class Admin::PledgesController < Admin::AdminController

  def index
    @pledges = Pledge.order( "created_at desc" ).paginate( page: params[:page], per_page: 30 )
    respond_to do |format|
      format.html
      format.csv { send_data Pledge.to_csv( @pledges ) }
    end
  end

end