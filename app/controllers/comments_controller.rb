class CommentsController < ApplicationController
  def create
    comment = Comment.create(comment_params)
    redirect_to "/buys/#{comment.buy.id}"
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, buy_id: params[:buy_id])
  end
end
