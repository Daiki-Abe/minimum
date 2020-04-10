require 'rails_helper'

describe Comment do
  describe '#create' do
    it "全てのカラムに入力があれば投稿できる" do
      user = create(:user, id: 1)
      buy = user.buys.create(id: 1, goods: "漫画", price: 500, image: "manga.jpg", description: "漫画は新しい価値観を提供してくれるから", user_id: user.id)
      comment = user.comments.build(text: "素晴らしいです", user_id: user.id, buy_id: buy.id) && buy.comments.build(text: "素晴らしいです", user_id: user.id, buy_id: buy.id)
      expect(comment).to be_valid
    end

    it "textカラムに入力がないと投稿できない" do
      user = create(:user, id: 1)
      buy = user.buys.create(id: 1, goods: "漫画", price: 500, image: "manga.jpg", description: "漫画は新しい価値観を提供してくれるから", user_id: user.id)
      comment = user.comments.build(text: "", user_id: user.id, buy_id: buy.id) && buy.comments.build(text: "", user_id: user.id, buy_id: buy.id)
      comment.valid?
      expect(comment.errors[:text]).to include("を入力してください")
    end

    it "user_idカラムに入力がないと投稿できない" do
      user = create(:user, id: 1)
      buy = user.buys.create(id: 1, goods: "漫画", price: 500, image: "manga.jpg", description: "漫画は新しい価値観を提供してくれるから", user_id: user.id)
      comment = buy.comments.build(text: "素晴らしいです", user_id: "", buy_id: buy.id)
      comment.valid?
      expect(comment.errors[:user]).to include("を入力してください")
    end

    it "buy_idカラムに入力がないと投稿できない" do
      user = create(:user, id: 1)
      buy = user.buys.create(id: 1, goods: "漫画", price: 500, image: "manga.jpg", description: "漫画は新しい価値観を提供してくれるから", user_id: user.id)
      comment = user.comments.build(text: "素晴らしいです", user_id: user.id, buy_id: "")
      comment.valid?
      expect(comment.errors[:buy]).to include("を入力してください")
    end
  end
end