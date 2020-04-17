require 'rails_helper'

describe User do
  describe '#create' do
    it '全てのカラムに入力があると登録できる' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'nameカラムに入力がないと登録できない' do
      user = build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include('を入力してください')
    end

    it 'emailカラムに入力がないと登録できない' do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include('を入力してください')
    end

    it 'passwordカラムに入力がないと登録できない' do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include('を入力してください')
    end

    it 'emailカラムに＠がないと登録ができない' do
      user = build(:user, email: 'kkkgamil.com')
      user.valid?
      expect(user.errors.full_messages).to include('メールアドレスは不正な値です')
    end

    it 'passwordカラムとpassword_confirmationカラムが違う値だと登録ができない' do
      user = build(:user, password_confirmation: '6666666')
      user.valid?
      expect(user.errors[:password_confirmation]).to include('とパスワードの入力が一致しません')
    end

    it 'passwordカラムに5文字以下だと登録ができない' do
      user = build(:user, password: '55555', password_confirmation: '55555')
      user.valid?
      expect(user.errors[:password]).to include('は6文字以上で入力してください')
    end

    it 'passwordカラムが6文字以上だと登録ができる' do
      user = build(:user, password: '666666', password_confirmation: '666666')
      expect(user).to be_valid
    end
  end
end
