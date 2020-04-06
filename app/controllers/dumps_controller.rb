class DumpsController < ApplicationController
  def new
    @dump = Dump.new
  end

  def create
    @dump = Dump.new(dump_params)
    @dump.save
    render :new unless @dump.save
  end

  private

  def dump_params
    params.require(:dump).permit(:goods, :price, :image, :description).merge(user_id: current_user.id)
end
