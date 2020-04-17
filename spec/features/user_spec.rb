require 'rails_helper'

feature 'User', type: :feature do
  feature 'ユーザー登録前' do
    scenario 'ユーザー登録ができるか' do
      visit root_path
      click_on 'Sign up'
      fill_in 'ニックネーム', with: 'ミニマムくん'
      fill_in 'メールアドレス', with: 'aaa@gmail.com'
      fill_in 'パスワード', with: '0000000'
      fill_in '確認用パスワード', with: '0000000'
      click_on '会員登録をする'
      expect(page).to have_content('アカウント登録が完了しました')
    end

    scenario 'ログインできないか' do
      visit root_path
      click_on 'Log in'
      fill_in 'メールアドレス', with: 'bbb@gmail.com'
      fill_in 'パスワード', with: '1111111'
      click_on 'ログインする'
      expect(page).to have_content 'メールアドレスまたはパスワードが違います'
    end
  end

  feature 'ユーザー登録後', type: :feature do
    let(:user) { create(:user) }

    background do
      visit new_user_session_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_on 'ログインする'
    end

    scenario 'ログインできているか' do
      expect(page).to have_content 'ログインしました。'
    end

    scenario 'ログアウトできるか' do
      click_on 'Log out'
      expect(page).to have_content 'ログアウトしました。'
    end

    scenario 'ユーザー情報編集ページに遷移できるか' do
      click_on 'My page'
      click_on 'Edit account'
      expect(current_path).to eq edit_user_registration_path
    end

    scenario 'ユーザー情報編集ページのフォームは正しい値か' do
      click_on 'My page'
      click_on 'Edit account'
      expect(page).to have_field(:user_name, with: user.name.to_s)
    end

    scenario 'ユーザー情報編集ができるか' do
      click_on 'My page'
      click_on 'Edit account'
      fill_in :user_current_password, with: user.password
      click_on '会員情報を変更する'
      expect(page).to have_content('アカウント情報を変更しました')
    end

    scenario 'ユーザー退会処理ができるか' do
      click_on 'My page'
      click_on 'Leave Minimum'
      expect(page).to have_content('アカウントを削除しました')
    end
  end
end
