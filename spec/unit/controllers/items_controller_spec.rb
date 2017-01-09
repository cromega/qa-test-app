require 'rails_helper'

describe ItemsController, type: :controller do
  describe "#new" do
    it "renders the new item page" do
      get :new

      expect(response).to render_template "new"
    end
  end

  describe "#create" do
    let(:user) { create(:user) }

    before do
      log_in(user)
    end

    it "creates the item" do
      post :create, params: {
        item: { name: "test", description: "test description", category: "test category" }
      }

      expect(user.items.count).to eq 1
    end

    it "redirects to the home page" do
      post :create, params: {
        item: { name: "test", description: "test description", category: "test category" }
      }

      expect(response). to redirect_to("/")
    end

    context "when the item is invalid" do
      it "renders the new page" do
        post :create, params: { item: {name: "test"} }

        expect(response).to render_template(:new)
      end
    end
  end

  describe "#index" do
    let(:user) { create(:user) }

    before do
      log_in(user)
    end

    it "renders the items page" do
      get :index

      expect(response).to render_template "user_items"
    end
  end

  describe "#edit" do
    let(:item) { create(:item, user: create(:user)) }

    before do
      log_in(item.user)
    end

    it "renders the edit item page" do
      get :edit, params: { id: item.id }

      expect(response).to render_template :edit
    end

    context "when the item does not exist" do
      it "redirects to the home page" do
        get :edit, params: { id: 0 }

        expect(response).to redirect_to "/"
      end
    end
  end

  describe "#update" do
    let(:user) { create(:user) }
    let(:item) { create(:item, user: user) }

    before do
      log_in(user)
    end

    it "updates the item" do
      patch :update, params: { id: item.id, item: { name: "new name" } }

      expect(item.reload.name).to eq "new name"
    end

    it "redirects to the items page" do
      patch :update, params: { id: item.id, item: { name: "new name" } }

      expect(response).to redirect_to user_items_path(user)
    end

    context "when the item is invalid" do
      it "renders the edit item details page" do
        patch :update, params: { id: item.id, item: { name: "" } }

        expect(response).to render_template :edit
      end
    end
  end
end
