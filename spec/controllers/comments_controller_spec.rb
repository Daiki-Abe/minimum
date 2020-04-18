require 'rails_helper'

describe CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:buy) { create(:buy) }
  let(:comment) { create(:comment) }

  describe 'POST #create', js: true do
    let(:params) { { buy_id: buy, comment: attributes_for(:comment, user_id: user.id, buy_id: buy.id) } }
    subject { post :create, params: params }

    it 'commentを保存すること' do
      login user
      expect { subject }.to change(Comment, :count).by(1)
    end
  end
end
