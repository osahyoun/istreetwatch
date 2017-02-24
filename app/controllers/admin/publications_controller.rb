class Admin::PublicationsController < Admin::AdminController
  before_action :set_publication, only: [:edit, :update, :destroy]

  def index
    @publications = Publication.order( "created_at desc" ).paginate( page: params[:page], per_page: 30 )
  end

  def new
    @publication = Publication.new
  end

  def create
    @publication = Publication.new(publication_params)

    if @publication.save
      redirect_to admin_publications_path, notice: "#{@publication.title} was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @publication.update(publication_params)
      redirect_to admin_publications_path, notice: "#{@publication.title} was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @publication.destroy
    redirect_to admin_publications_path, notice: 'Publication was successfully destroyed.'
  end

  private
    def set_publication
      @publication = Publication.find(params[:id])
    end

    def publication_params
      params.require(:publication).permit( :title, :summary, :document, :picture )
    end
end