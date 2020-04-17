require 'rails_helper'

describe DumpsController, type: :controller do
  let(:user) {create(:user)}
  let(:tag) {create(:tag)}
  let(:dump) {create(:dump)}

  describe 'GET #index' do
    it '@dumpsに正しい値が入っていること' do
      dumps = create_list(:dump, 3)
      get :index
      expect(assigns(:dumps)).to match(dumps.sort{ |a, b| b.created_at <=> a.created_at } )
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
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'POST #create' do
    let(:params) { { dump: attributes_for(:dump, user_id: user.id, dump_tags_attributes: [tag_id: tag.id]) } }

    context 'ログインしてる場合' do
      before do
        login user
      end

      context '保存に成功した場合' do
        subject {
          post :create,
          params: params
        }

        it 'dumpを保存すること' do
          expect{subject}.to change(Dump, :count).by(1)
        end

        it 'createページに遷移すること' do
          subject
          expect(response.status).to eq(200)
        end
      end

      context '保存に失敗した場合' do
        let(:invalid_params) { { dump: attributes_for(:dump, user_id: user.id, dump_tags_attributes: [tag_id: ""]) } }

        subject {
          post :create,
          params: invalid_params
        }

        it 'dumpを保存しないこと' do
          expect{subject}.not_to change(Dump, :count)
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
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'GET #show' do
    before do
      get :show, params: {id: dump}
    end

    it '@dumpに正しい値が入っていること' do
      expect(assigns(:dump)).to eq dump
    end

    it 'showページに遷移されること' do
      expect(response.status).to eq(200)
    end
  end

  describe 'GET #edit' do
    context 'ログインしてる場合' do
      before do
        login user
        get :edit, params: {id: dump}
      end

      it "@dumpに正しい値が入っていること" do
        expect(assigns(:dump)).to eq dump
      end
      
      it "editページに遷移すること" do
        expect(response).to render_template :edit
      end
    end

    context 'ログインしていない場合' do
      it 'indexページにリダイレクトすること' do
        get :edit, params: {id: dump}
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "PATCH #update" do
  let(:params) { { id: dump, dump: attributes_for(:dump, goods: "hogehoge", user_id: user.id, dump_tags_attributes: [tag_id: tag.id]) } }

    context 'ログインしている場合' do
      before do
        login user
        patch :update, params: params
      end

      context '更新に成功した場合' do
        it '@dumpに正しい値が入っていること' do
          expect(assigns(:dump)).to eq dump
        end

        it '更新処理がされること' do
          dump.reload
          expect(dump.goods).to eq("hogehoge") 
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
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'DLETE #destroy' do
    context 'ログインしている場合' do
      before do
        login user
      end

      it '削除されること' do
        dump = create(:dump)
        expect{delete :destroy, params: {id: dump}}.to change(Dump, :count).by(-1)
      end

      it 'destroyページに遷移されること' do
        expect(delete :destroy, params: {id: dump}).to render_template :destroy
      end
    end

    context 'ログインしていない場合' do
      it 'indexページに遷移すること' do
        delete :destroy, params: {id: dump}
        expect(response).to redirect_to(root_path)
      end
    end
  end
end