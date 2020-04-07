class DumpCommentsController < ApplicationController
  before_action :move_to_index, only: [:create]
  def create
    @comment = Dump_comment.create(comment_params)
    respond_to do |format|
      format.html {redirect_to "/dumps/#{@comment.buy.id}"}
      format.json 
  end

  private

  def comment_params
    params.require(:dump_comment).permit(:text).merge(user_id: current_user.id, dump_id: params[:dump_id])
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in? 
  end

end
