require 'rails_helper'

describe BuysController, type: :controller do
  describe 'GET #new' do
    it "new.html.hamlに遷移すること" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    it "@buyに正しい値が入っていること" do
      buy = create(:buy)
      check = buy.buy_tags.build(buy_id: 1, tag_id: 5)
      get :edit, params: {id: check}
      expect(assigns(:buy)).to eq check
    end

    it "edit.html.hamlに遷移すること" do
    end
  end
end