class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def mybuy
    @user = User.find(params[:id])
    @buys = Buy.includes(:user)
    @buys = params[:tag_id].present? ? Tag.find(params[:tag_id]).buys : Buy.all
  end
end
