class PledgesController < ApplicationController

  def new
    @pledge = Pledge.new
  end

  def sent
  end

  def create
    @pledge = Pledge.new(pledge_params)

    respond_to do |format|
      if @pledge.save
        #format.html { redirect_to @report, notice: 'Report was successfully created.' }
        format.html { redirect_to pledge_sent_path }
      else
        format.html { render :new }
        #format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_pledge
    @pledge = Pledge.find(params[:id])
  end

  def pledge_params
    params.require(:pledge).permit(:name, :email)
  end
end
