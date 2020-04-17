require 'rails_helper'

describe Comment do
  describe '#create' do
    it "全てのカラムに入力があれば投稿できる" do
      comment = build(:dump_comment)
      expect(comment).to be_valid
    end

    it "textカラムに入力がないと投稿できない" do
      comment = build(:dump_comment, text: "")
      comment.valid?
      expect(comment.errors[:text]).to include("を入力してください")
    end

    it "user_idカラムに入力がないと投稿できない" do
      comment = build(:dump_comment, user_id: "")
      comment.valid?
      expect(comment.errors[:user]).to include("を入力してください")
    end

    it "dump_idカラムに入力がないと投稿できない" do
      comment = build(:dump_comment, dump_id: "")
      comment.valid?
      expect(comment.errors[:dump]).to include("を入力してください")
    end
  end
end