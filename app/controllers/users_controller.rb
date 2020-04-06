class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    buys = @user.buys
    buy_id = []
    buys.each do |buy|
      buy_id << buy.id
    end
    @hate_count = Hate.where(buy_id: buy_id).count
  end

  def mybuy
    @user = User.find(params[:id])
    @buys = params[:tag_id].present? ? Tag.find(params[:tag_id]).buys.includes(:user) : Buy.includes(:user)
  end

  def search
    @user = User.find(params[:id])
    @buys = Buy.search(params[:keyword])
  end
end
