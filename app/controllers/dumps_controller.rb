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
    params.require(:dump).permit(:goods, :price, :image, :description, dump_tags_attributes: [:dump_id, :tag_id, :_destroy, :id]).merge(user_id: current_user.id)
  end
end
