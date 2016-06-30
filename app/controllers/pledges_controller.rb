class PledgesController < ApplicationController
  def create
    @pledge = Pledge.new(pledge_params)
    @pledge.save
    redirect_to thankyou_pledges_path
  end

  private

  def pledge_params
    params.require(:pledge).permit(:name, :email)
  end
end
