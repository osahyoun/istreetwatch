class PledgesController < ApplicationController
  def create
    @pledge = Pledge.new(pledge_params)

    respond_to do |format|
      if @pledge.save
        format.html { redirect_to thankyou_pledges_path }
        format.json { render json: @pledge }
      else
        format.html { render :new }
        format.json { render json: @pledge.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def pledge_params
    params.require(:pledge).permit(:name, :email)
  end
end
