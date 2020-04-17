require 'rails_helper'

feature 'Buy', type: :feature do
  feature 'ログイン前', type: :feature do
    background do
      visit buys_path
    end

    scenario 'ホーム画面が表示されているか' do
      expect(page).to have_link 'Sign up'
    end

    scenario 'ログインページに遷移するか' do
      click_on 'Log in'
      expect(current_path).to eq new_user_session_path
    end

    scenario 'showページに遷移できるか' do
      buy_1 = create(:buy)
      click_on '『購入品』'
      click_on 'SHOW'
      expect(current_path).to eq buy_path(buy_1.id)
    end

    scenario 'showページにコメントフォームがないか' do
      create(:buy)
      click_on '『購入品』'
      click_on 'SHOW'
      expect(page).to have_no_button 'SEND'
    end

    scenario 'editページへのリンクが表示されないか' do
      buy_1 = create(:buy)
      click_on '『購入品』'
      expect(page).to have_no_link edit_buy_path(buy_1.id)
    end

    scenario 'deleteページへのリンクが表示されないか' do
      buy_1 = create(:buy)
      click_on '『購入品』'
      expect(page).to have_no_link buy_path(buy_1.id)
    end

    scenario 'hateページへのリンクが表示されないか' do
      create(:buy)
      click_on '『購入品』'
      expect(page).to have_no_css '.hate-path'
    end

    scenario 'フリーワード検索ができるか' do
      create(:buy, goods: 'ボタンダウンシャツ')
      create(:buy, goods: '小説')
      visit buys_path
      fill_in :keyword, with: 'ボタンダウン'
      click_on '検索'
      expect(page).to have_content('ボタンダウンシャツ')
      expect(page).to have_no_content('小説')
    end
  end

  feature 'ログイン後', type: :feature do
    let(:user) { create(:user) }
    let(:buy) { create(:buy) }

    background do
      visit new_user_session_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_on 'ログインする'
    end

    scenario '『購入品』ページに遷移できるか' do
      click_on '『購入品』'
      expect(current_path).to eq buys_path
    end

    scenario 'showページに遷移できるか' do
      buy_1 = create(:buy, user_id: user.id)
      click_on '『購入品』'
      click_on 'SHOW'
      expect(current_path).to eq buy_path(buy_1.id)
    end

    scenario 'showページにコメントフォームがあるか' do
      create(:buy, user_id: user.id)
      click_on '『購入品』'
      click_on 'SHOW'
      expect(page).to have_button 'SEND'
    end

    scenario 'コメントができるか' do
      create(:buy, user_id: user.id)
      click_on '『購入品』'
      click_on 'SHOW'
      fill_in class: 'buy-comment__send-text', with: '素晴らしいです'
      click_on 'SEND'
      expect(page).to have_content '素晴らしいです'
    end

    scenario 'editページに遷移できるか' do
      buy_1 = create(:buy, user_id: user.id)
      click_on '『購入品』'
      click_on 'EDIT'
      expect(current_path).to eq edit_buy_path(buy_1.id)
    end

    scenario 'editページのフォーム内容は正しい値か' do
      buy_1 = create(:buy, user_id: user.id)
      click_on '『購入品』'
      click_on 'EDIT'
      expect(page).to have_field(:goods, with: buy_1.goods.to_s)
    end

    scenario 'editページのフォーム送信後のページに遷移できるか' do
      buy_1 = create(:buy, user_id: user.id)
      click_on '『購入品』'
      click_on 'EDIT'
      click_on 'Send'
      expect(current_path).to eq buy_path(buy_1.id)
    end

    scenario 'deleteページに遷移できるか' do
      buy_1 = create(:buy, user_id: user.id)
      click_on '『購入品』'
      click_on 'DELETE'
      expect(current_path).to eq buy_path(buy_1.id)
    end

    scenario 'deleteできるか' do
      create(:buy, user_id: user.id)
      click_on '『購入品』'
      expect { click_on 'DELETE' }.to change(Buy, :count).by(-1)
    end

    scenario 'hateボタンが表示されているか' do
      create(:buy, user_id: user.id)
      click_on '『購入品』'
      expect(page).to have_css '.hate-path'
    end

    scenario 'フリーワード検索ができるか' do
      create(:buy, goods: 'ボタンダウンシャツ')
      create(:buy, goods: '小説')
      visit buys_path
      fill_in :keyword, with: 'ボタンダウン'
      click_on '検索'
      expect(page).to have_content('ボタンダウンシャツ')
      expect(page).to have_no_content('小説')
    end

    scenario 'mypageに遷移できるか' do
      click_on 'My page'
      expect(current_path).to eq user_path(user.id)
    end

    scenario 'Send『購入品』(create)ページに遷移できるか' do
      click_on 'My page'
      click_on 'Send『購入品』'
      expect(current_path).to eq new_buy_path
    end

    scenario 'createできるか' do
      click_on 'My page'
      click_on 'Send『購入品』'
      expect do
        fill_in class: 'send__buy-goods', with: buy.goods
        fill_in class: 'send__buy-price', with: buy.price
        fill_in class: 'send__buy-description', with: buy.description
        click_on 'Send'
      end.to change(Buy, :count).by(1)
    end

    scenario 'My『購入品』ページに遷移できるか' do
      click_on 'My page'
      click_on 'My『購入品』'
      expect(current_path).to eq mybuy_user_path(user.id)
    end
  end
end
