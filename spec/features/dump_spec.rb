require 'rails_helper'

feature 'Dump', type: :feature do
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
      dump1 = create(:dump)
      click_on "『断捨離』"
      click_on "SHOW"
      expect(current_path).to eq dump_path(dump1.id)
    end

    scenario 'showページにコメントフォームがないか' do
      dump1 = create(:dump)
      click_on "『断捨離』"
      click_on "SHOW"
      expect(page).to have_no_button "SEND"
    end

    scenario 'editページへのリンクが表示されないか' do
      dump1 = create(:dump)
      click_on "『断捨離』"
      expect(page).to have_no_link edit_dump_path(dump1.id)
    end

    scenario 'deleteページへのリンクが表示されないか' do
      dump1 = create(:dump)
      click_on "『断捨離』"
      expect(page).to have_no_link dump_path(dump1.id)
    end

    scenario 'likeページへのリンクが表示されないか' do
      dump1 = create(:dump)
      click_on "『断捨離』"
      expect(page).to have_no_css ".like-path"
    end

    scenario 'フリーワード検索ができるか' do
      dump1 = create(:dump, goods: "ボタンダウンシャツ")
      dump2 = create(:dump, goods: "小説")
      visit root_path
      fill_in :keyword, with: "ボタンダウン"
      click_on "検索"
      expect(page).to have_content("ボタンダウンシャツ")
      expect(page).to have_no_content("小説")
    end
  end

  feature 'ログイン後', type: :feature do

    let(:user) {create(:user)}
    let(:dump) {create(:dump)}

    background do
      visit new_user_session_path
      fill_in "メールアドレス", with: user.email
      fill_in "パスワード", with: user.password
      click_on "ログインする"
    end

    scenario '『断捨離』ページに遷移できるか' do
      click_on "『断捨離』"
      expect(current_path).to eq dumps_path
    end

    scenario 'showページに遷移できるか' do
      dump1 = create(:dump, user_id: user.id)
      click_on "『断捨離』"
      click_on "SHOW"
      expect(current_path).to eq dump_path(dump1.id)
    end

    scenario 'showページにコメントフォームがあるか' do
      dump1 = create(:dump, user_id: user.id)
      click_on "『断捨離』"
      click_on "SHOW"
      expect(page).to have_button "SEND"
    end

    scenario 'editページに遷移できるか' do
      dump1 = create(:dump, user_id: user.id)
      click_on "『断捨離』"
      click_on "EDIT"
      expect(current_path).to eq edit_dump_path(dump1.id)
    end

    scenario 'editページのフォーム内容は正しい値か' do
      dump1 = create(:dump, user_id: user.id)
      click_on "『断捨離』"
      click_on "EDIT"
      expect(page).to have_field(:goods, with: "#{dump1.goods}")
    end

    scenario 'editページのフォーム送信後のページに遷移できるか' do
      dump1 = create(:dump, user_id: user.id)
      click_on "『断捨離』"
      click_on "EDIT"
      click_on "Send"
      expect(current_path).to eq dump_path(dump1.id)
    end

    scenario 'deleteページに遷移できるか' do
      dump1 = create(:dump, user_id: user.id)
      click_on "『断捨離』"
      click_on "DELETE"
      expect(current_path).to eq dump_path(dump1.id)
    end

    scenario 'deleteできるか' do
      dump1 = create(:dump, user_id: user.id)
      click_on "『断捨離』"
      expect{click_on "DELETE"}.to change(Dump, :count).by(-1)
    end

    scenario 'likeボタンが表示されているか' do
      dump1 = create(:dump, user_id: user.id)
      click_on "『断捨離』"
      expect(page).to have_css ".like-path"
    end

    scenario 'フリーワード検索ができるか' do
      dump1 = create(:dump, goods: "ボタンダウンシャツ")
      dump2 = create(:dump, goods: "小説")
      visit root_path
      fill_in :keyword, with: "ボタンダウン"
      click_on "検索"
      expect(page).to have_content("ボタンダウンシャツ")
      expect(page).to have_no_content("小説")
    end

    scenario 'mypageに遷移できるか' do
      click_on "My page"
      expect(current_path).to eq user_path(user.id)
    end

    scenario 'Send『断捨離』(create)ページに遷移できるか' do
      click_on "My page"
      click_on "Send『断捨離』"
      expect(current_path).to eq new_dump_path
    end

    scenario 'createできるか' do
      click_on "My page"
      click_on "Send『断捨離』"
      expect{
        fill_in class: "send__buy-goods", with: dump.goods
        fill_in class: "send__buy-price", with: dump.price
        fill_in class: "send__buy-description", with: dump.description
        click_on "Send"
      }.to change(Dump, :count).by(1)
    end

    scenario 'My『断捨離』ページに遷移できるか' do
      click_on "My page"
      click_on "My『断捨離』"
      expect(current_path).to eq mydump_user_path(user.id)
    end
  end
end