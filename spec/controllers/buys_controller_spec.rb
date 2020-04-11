require 'rails_helper'

describe BuysController, type: :controller do
  let(:user) {create(:user)}
  let(:buy) {create(:buy)}

  describe 'GET #index' do
    it "@buysに正しい値が入っていること" do
      buys = create_list(:buy, 3)
      get :index
      expect(assigns(:buys)).to match(buys.sort{ |a, b| b.created_at <=> a.created_at } )
    end

    it "index.haml.hamlに遷移すること" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #new' do
    context 'ログインしている場合' do
      before do
        login user
        get :new
      end

      it "new.html.hamlに遷移すること" do
        expect(response).to render_template :new
      end
    end

    context 'ログインしていない場合' do
      before do
        get :new
      end

      it 'indexページにリダイレクトすること' do
        expect(response).to redirect_to(buys_path)
      end
    end
  end

  

  describe 'GET #edit' do
    context 'ログインしてる場合' do
      before do
        login user
        get :edit, params: {id: buy}
      end

      it "@buyに正しい値が入っていること" do
        expect(assigns(:buy)).to eq buy
      end
      
      it "edit.html.hamlに遷移すること" do
        expect(response).to render_template :edit
      end
    end

    context 'ログインしていない場合' do
      before do
        get :edit, params: {id: buy}
      end

      it 'indexページにリダイレクトすること' do
        expect(response).to redirect_to(buys_path)
      end
    end
  end
end