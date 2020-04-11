require 'rails_helper'

describe BuysController, type: :controller do
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
    it "new.html.hamlに遷移すること" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    it "@buyに正しい値が入っていること" do
      buy = create(:buy)
      get :edit, params: {id: buy}
      expect(assigns(:buy)).to eq buy
    end

    it "edit.html.hamlに遷移すること" do
      buy = create(:buy)
      get :edit, params: {id: buy}
      expect(response).to render_template :edit
    end
  end
end