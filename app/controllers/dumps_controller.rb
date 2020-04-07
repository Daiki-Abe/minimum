class DumpsController < ApplicationController
  def index
    @dumps = params[:tag_id].present? ? Tag.find(params[:tag_id]).dumps.includes(:user).order("created_at DESC").page(params[:page]).per(18) : Dump.includes(:user).order("created_at DESC").page(params[:page]).per(18)
  end

  def new
    @dump = Dump.new
    dump_tags = @dump.dump_tags.build
  end

  def create
    @dump = Dump.new(dump_params)
    @dump.save
    render :new unless @dump.save
  end

  def show
    @dump = Dump.find(params[:id])
  end

  def destroy
    @dump = Dump.find(params[:id])
    @dump.destroy
  end

  def search
    @dumps = Dump.search(params[:keyword]).order("created_at DESC").page(params[:page]).per(18)
  end

  private

  def dump_params
    params.require(:dump).permit(:goods, :price, :image, :description, dump_tags_attributes: [:dump_id, :tag_id, :_destroy, :id]).merge(user_id: current_user.id)
  end
end
