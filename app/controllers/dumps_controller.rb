class DumpsController < ApplicationController
  before_action :move_to_index, except: [:index, :show, :search]
  before_action :set_dump, only: [:show, :edit, :update, :destroy]

  def index
    @dumps = params[:tag_id].present? ? Tag.find(params[:tag_id]).dumps.includes(:user).order('created_at DESC').page(params[:page]).per(18) : Dump.includes(:user).order('created_at DESC').page(params[:page]).per(18)
  end

  def new
    @dump = Dump.new
    @dump.dump_tags.build
  end

  def create
    @dump = Dump.new(dump_params)
    @dump.save
    render :new unless @dump.save
  end

  def show
    @comment = DumpComment.new
    @comments = @dump.dump_comments.includes(:user)
  end

  def edit
    @dump.dump_tags
  end

  def update
    @dump.update(dump_params)
    render :edit unless @dump.update(dump_params)
  end

  def destroy
    @dump.destroy
  end

  def search
    @dumps = Dump.search(params[:keyword]).order('created_at DESC').page(params[:page]).per(18)
  end

  private

  def dump_params
    params.require(:dump).permit(:goods, :price, :image, :description, dump_tags_attributes: [:dump_id, :tag_id, :_destroy, :id]).merge(user_id: current_user.id)
  end

  def set_dump
    @dump = Dump.find(params[:id])
  end
end
