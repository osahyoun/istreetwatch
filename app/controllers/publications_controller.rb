class PublicationsController < ApplicationController

  def index
    @publications = Publication.order( "created_at desc" ).paginate( page: params[:page], per_page: 30 )
  end

end
