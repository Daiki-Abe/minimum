require 'rails_helper'

feature 'Buy', type: :feature do
  feature 'ログイン前', type: :feature do
    
    background do
      visit root_path
    end

    scenario 'ホーム画面が表示されているか' do
      expect(page).to have_link "Sign up"
    end

    scenario 'ログインページに遷移するか' do
      click_on "Log in"
      expect(current_path).to eq new_user_session_path
    end

    scenario 'showページに遷移できるか' do
      buy_1 = create(:buy)
      click_on "『購入品』"
      click_on "SHOW"
      expect(current_path).to eq buy_path(buy_1.id)
    end

    scenario 'showページにコメントフォームがないか' do
      buy_1 = create(:buy)
      click_on "『購入品』"
      click_on "SHOW"
      expect(page).to have_no_button "SEND"
    end

    scenario 'editページへのリンクが表示されないか' do
      buy_1 = create(:buy)
      click_on "『購入品』"
      expect(page).to have_no_link edit_buy_path(buy_1.id)
    end

    scenario 'deleteページへのリンクが表示されないか' do
      buy_1 = create(:buy)
      click_on "『購入品』"
      expect(page).to have_no_link buy_path(buy_1.id)
    end

    scenario 'hateページへのリンクが表示されないか' do
      buy_1 = create(:buy)
      click_on "『購入品』"
      expect(page).to have_no_css ".hate-path"
    end
  end

  feature 'ログイン後', type: :feature do

    let(:user) {create(:user)}
    let(:buy) {create(:buy)}

    background do
      visit new_user_session_path
      fill_in "メールアドレス", with: user.email
      fill_in "パスワード", with: user.password
      click_on "ログインする"
    end

    scenario '『購入品』ページに遷移できるか' do
      click_on "『購入品』"
      expect(current_path).to eq buys_path
    end

    scenario 'showページに遷移できるか' do
      buy_1 = create(:buy, user_id: user.id)
      click_on "『購入品』"
      click_on "SHOW"
      expect(current_path).to eq buy_path(buy_1.id)
    end

    scenario 'showページにコメントフォームがあるか' do
      buy_1 = create(:buy, user_id: user.id)
      click_on "『購入品』"
      click_on "SHOW"
      expect(page).to have_button "SEND"
    end

    scenario 'editページに遷移できるか' do
      buy_1 = create(:buy, user_id: user.id)
      click_on "『購入品』"
      click_on "EDIT"
      expect(current_path).to eq edit_buy_path(buy_1.id)
    end

    scenario 'editページのフォーム内容は正しい値か' do
      buy_1 = create(:buy, user_id: user.id)
      click_on "『購入品』"
      click_on "EDIT"
      expect(page).to have_field(:goods, with: "#{buy_1.goods}")
    end

    scenario 'editページのフォーム送信後のページに遷移できるか' do
      buy_1 = create(:buy, user_id: user.id)
      click_on "『購入品』"
      click_on "EDIT"
      click_on "Send"
      expect(current_path).to eq buy_path(buy_1.id)
    end

    scenario 'deleteページに遷移できるか' do
      buy_1 = create(:buy, user_id: user.id)
      click_on "『購入品』"
      click_on "DELETE"
      expect(current_path).to eq buy_path(buy_1.id)
    end

    scenario 'deleteできるか' do
      buy_1 = create(:buy, user_id: user.id)
      click_on "『購入品』"
      expect{click_on "DELETE"}.to change(Buy, :count).by(-1)
    end

    scenario 'hateボタンが表示されているか' do
      buy_1 = create(:buy, user_id: user.id)
      click_on "『購入品』"
      expect(page).to have_css ".hate-path"
    end

    scenario 'mypageに遷移できるか' do
      click_on "My page"
      expect(current_path).to eq user_path(user.id)
    end

    scenario 'Send『購入品』(create)ページに遷移できるか' do
      click_on "My page"
      click_on "Send『購入品』"
      expect(current_path).to eq new_buy_path
    end

    scenario 'createできるか' do
      click_on "My page"
      click_on "Send『購入品』"
      expect{
        fill_in class: "send__buy-goods", with: buy.goods
        fill_in class: "send__buy-price", with: buy.price
        fill_in class: "send__buy-description", with: buy.description
        click_on "Send"
      }.to change(Buy, :count).by(1)
    end

    scenario 'My『購入品』ページに遷移できるか' do
      click_on "My page"
      click_on "My『購入品』"
      expect(current_path).to eq mybuy_user_path(user.id)
    end
  end
end