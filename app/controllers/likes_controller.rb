class LikesController < ApplicationController
  before_action :set_dump, :move_to_index, only: [:create, :destroy]

  def create
    @like = Like.create(user_id: current_user.id, dump_id: @dump.id)
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, dump_id: @dump.id)
    @like.destroy
  end

  private

  def set_dump
    @dump = Dump.find(params[:dump_id])
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in? 
  end

end
