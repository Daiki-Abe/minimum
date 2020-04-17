require 'rails_helper'

describe BuysController, type: :controller do
  let(:user) {create(:user)}
  let(:tag) {create(:tag)}
  let(:buy) {create(:buy)}

  describe 'GET #index' do
    it '@buysに正しい値が入っていること' do
      buys = create_list(:buy, 3)
      get :index
      expect(assigns(:buys)).to match(buys.sort{ |a, b| b.created_at <=> a.created_at } )
    end

    it 'indexページに遷移すること' do
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

      it 'newページに遷移すること' do
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

  describe 'POST #create' do
    let(:params) { { buy: attributes_for(:buy, user_id: user.id, buy_tags_attributes: [tag_id: tag.id]) } }

    context 'ログインしてる場合' do
      before do
        login user
      end

      context '保存に成功した場合' do
        subject {
          post :create,
          params: params
        }

        it 'buyを保存すること' do
          expect{subject}.to change(Buy, :count).by(1)
        end

        it 'createページに遷移すること' do
          subject
          expect(response.status).to render_template :create
        end
      end

      context '保存に失敗した場合' do
        let(:invalid_params) { { buy: attributes_for(:buy, user_id: user.id, buy_tags_attributes: [tag_id: ""]) } }

        subject {
          post :create,
          params: invalid_params
        }

        it 'buyを保存しないこと' do
          expect{subject}.not_to change(Buy, :count)
        end

        it 'newページに遷移されること' do
          subject
          expect(response).to render_template :new
        end
      end
    end

    context 'ログインしていない場合' do
      it 'indexページにリダイレクトすること' do
        post :create, params: params
        expect(response).to redirect_to(buys_path)
      end
    end
  end

  describe 'GET #show' do
    before do
      get :show, params: {id: buy}
    end

    it '@buyに正しい値が入っていること' do
      expect(assigns(:buy)).to eq buy
    end

    it 'showページに遷移されること' do
      expect(response.status).to eq(200)
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
      
      it "editページに遷移すること" do
        expect(response).to render_template :edit
      end
    end

    context 'ログインしていない場合' do
      it 'indexページにリダイレクトすること' do
        get :edit, params: {id: buy}
        expect(response).to redirect_to(buys_path)
      end
    end
  end

  describe "PATCH #update" do
  let(:params) { { id: buy, buy: attributes_for(:buy, goods: "hogehoge", user_id: user.id, buy_tags_attributes: [tag_id: tag.id]) } }

    context 'ログインしている場合' do
      before do
        login user
        patch :update, params: params
      end

      context '更新に成功した場合' do
        it '@buyに正しい値が入っていること' do
          expect(assigns(:buy)).to eq buy
        end

        it '更新処理がされること' do
          buy.reload
          expect(buy.goods).to eq("hogehoge") 
        end

        it "updateページに遷移すること" do
          expect(response.status).to eq(200)
        end
      end

      context '更新に失敗した場合' do
        it 'editページに遷移されること' do
          patch :update, params: params
          expect(response).to render_template :update
        end
      end
    end

    context 'ログインしていない場合' do
      it 'indexページに遷移されること' do
        patch :update, params: params
        expect(response).to redirect_to(buys_path)
      end
    end
  end

  describe 'DLETE #destroy' do
    context 'ログインしている場合' do
      before do
        login user
      end

      it '削除されること' do
        buy = create(:buy)
        expect{delete :destroy, params: {id: buy}}.to change(Buy, :count).by(-1)
      end

      it 'destroyページに遷移されること' do
        expect(delete :destroy, params: {id: buy}).to render_template :destroy
      end
    end

    context 'ログインしていない場合' do
      it 'indexページに遷移すること' do
        delete :destroy, params: {id: buy}
        expect(response).to redirect_to(buys_path)
      end
    end
  end
end