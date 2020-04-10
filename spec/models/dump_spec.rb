require 'rails_helper'

describe Dump do
  describe '#create' do
    it "全てのカラムに入力があれば投稿できる" do
      user = create(:user)
      Tag.create(id: 4, name: "衣服")
      dump = user.dumps.create(goods: "洋服", price: 5000, image: "youhuku.jpg", description: "同じような服を何枚も持っているから", user_id: 1)
      check = dump.dump_tags.build(dump_id: 1, tag_id: 4)
      expect(check).to be_valid
    end

    it "goodsカラムに入力がないと投稿できない" do
      dump = build(:dump, goods: "")
      dump.valid?
      expect(dump.errors[:goods]).to include("を入力してください")
    end

    it "priceカラムに入力がないと投稿できない" do
      dump = build(:dump, price: "")
      dump.valid?
      expect(dump.errors[:price]).to include("を入力してください")
    end

    it "priceカラムが半角入力ではないと投稿できない" do
      dump = build(:dump, price: "５００円")
      dump.valid?
      expect(dump.errors[:price]).to include("は半角数字で入力してください")
    end

    it "descriptionカラムに入力がないと投稿できない" do
      dump = build(:dump, description: "")
      dump.valid?
      expect(dump.errors[:description]).to include("を入力してください")
    end

    it "タグを選択しないと投稿できない" do
      user = create(:user)
      Tag.create(id: 4, name: "衣服")
      dump = user.dumps.create(goods: "洋服", price: 5000, image: "youhuku.jpg", description: "同じような服を何枚も持っているから", user_id: 1)
      dump.dump_tags.build
      dump.valid?
      expect(dump.errors[:dump_tags]).to include("を選択してください")
    end
  end
end