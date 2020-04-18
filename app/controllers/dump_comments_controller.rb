class DumpCommentsController < ApplicationController
  def create
    @comment = DumpComment.create(comment_params)
    respond_to do |format|
      format.html { redirect_to "/dumps/#{@comment.dump.id}" }
      format.json
    end
  end

  private

  def comment_params
    params.require(:dump_comment).permit(:text).merge(user_id: current_user.id, dump_id: params[:dump_id])
  end
end
