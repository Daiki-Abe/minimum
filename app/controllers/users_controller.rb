class UsersController < ApplicationController
  before_action :set_user, only: [:show, :mydump, :mybuy, :dumpsearch, :search]

  def show
    @hate_count = User.set_hate_count(@user)

    dumps = @user.dumps
    dump_id = []
    dumps.each do |dump|
      dump_id << dump.id
    end
    @dump_count = Like.where(dump_id: dump_id).count
  end

  def mydump
    @dumps = params[:tag_id].present? ? Tag.find(params[:tag_id]).dumps.includes(:user) : Dump.includes(:user)
  end

  def mybuy
    @buys = params[:tag_id].present? ? Tag.find(params[:tag_id]).buys.includes(:user) : Buy.includes(:user)
  end

  def dumpsearch
    @dumps = Dump.search(params[:keyword])
  end

  def search
    @buys = Buy.search(params[:keyword])
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

end
