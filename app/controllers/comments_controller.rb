class CommentsController < ApplicationController
  before_action :move_to_index, only: [:create]
  def create
    @comment = Comment.create(comment_params)
    respond_to do |format|
      format.html {redirect_to "/buys/#{@comment.buy.id}"}
      format.json
    end
  end

  private
  
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, buy_id: params[:buy_id])
  end

end
