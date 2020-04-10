require 'rails_helper'

describe Comment do
  describe '#create' do
    it "全てのカラムに入力があれば投稿できる" do
      user = create(:user, id: 1)
      dump = user.dumps.create(id: 1, goods: "漫画", price: 500, image: "manga.jpg", description: "漫画を読む頻度が減ったから", user_id: user.id)
      comment = user.dump_comments.build(text: "素晴らしいです", user_id: user.id, dump_id: dump.id) && dump.dump_comments.build(text: "素晴らしいです", user_id: user.id, dump_id: dump.id)
      expect(comment).to be_valid
    end

    it "textカラムに入力がないと投稿できない" do
      user = create(:user, id: 1)
      dump = user.dumps.create(id: 1, goods: "漫画", price: 500, image: "manga.jpg", description: "漫画を読む頻度が減ったから", user_id: user.id)
      comment = user.dump_comments.build(text: "", user_id: user.id, dump_id: dump.id) && dump.dump_comments.build(text: "", user_id: user.id, dump_id: dump.id)
      comment.valid?
      expect(comment.errors[:text]).to include("を入力してください")
    end

    it "user_idカラムに入力がないと投稿できない" do
      user = create(:user, id: 1)
      dump = user.dumps.create(id: 1, goods: "漫画", price: 500, image: "manga.jpg", description: "漫画を読む頻度が減ったから", user_id: user.id)
      comment = dump.dump_comments.build(text: "素晴らしいです", user_id: "", dump_id: dump.id)
      comment.valid?
      expect(comment.errors[:user]).to include("を入力してください")
    end

    it "dump_idカラムに入力がないと投稿できない" do
      user = create(:user, id: 1)
      dump = user.dumps.create(id: 1, goods: "漫画", price: 500, image: "manga.jpg", description: "漫画を読む頻度が減ったから", user_id: user.id)
      comment = user.dump_comments.build(text: "素晴らしいです", user_id: user.id, dump_id: "")
      comment.valid?
      expect(comment.errors[:dump]).to include("を入力してください")
    end
  end
end