require 'rails_helper'

describe Buy do
  describe '#create' do
    it '全てのカラムに入力があれば投稿できる' do
      buy = build(:buy)
      expect(buy).to be_valid
    end

    it 'goodsカラムに入力がないと投稿できない' do
      buy = build(:buy, goods: '')
      buy.valid?
      expect(buy.errors[:goods]).to include('を入力してください')
    end

    it 'priceカラムに入力がないと投稿できない' do
      buy = build(:buy, price: '')
      buy.valid?
      expect(buy.errors[:price]).to include('を入力してください')
    end

    it 'priceカラムが半角入力ではないと投稿できない' do
      buy = build(:buy, price: '５００円')
      buy.valid?
      expect(buy.errors[:price]).to include('は半角数字で入力してください')
    end

    it 'descriptionカラムに入力がないと投稿できない' do
      buy = build(:buy, description: '')
      buy.valid?
      expect(buy.errors[:description]).to include('を入力してください')
    end

    it 'タグを選択しないと投稿できない' do
      buy = build(:buy)
      buy.buy_tags.build
      buy.valid?
      expect(buy.errors[:buy_tags]).to include('を選択してください')
    end

    it 'user_idカラムに入力がないと投稿できない' do
      buy = build(:buy, user_id: '')
      buy.valid?
      expect(buy.errors[:user]).to include('を入力してください')
    end
  end
end
