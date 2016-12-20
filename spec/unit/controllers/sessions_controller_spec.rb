require 'rails_helper'

describe SessionsController, type: :controller do
  describe "#new" do
    it "renders the login page" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "#create" do
    context "when the user exists" do
      let(:password) { "foobar" }
      let(:user) { create(:user, password: password) }

      it "sets the session" do
        post :create, params: { username: user.username, password: password }
        expect(session[:user_id]).to eq user.id
      end

      it "redirects to the main page" do
        post :create, params: { username: user.username, password: password }
        expect(response).to redirect_to "/"
      end
    end

    context "when the user does not exist" do
      it "redirects to the login page" do
        post :create, params: { username: "dontexist", password: "foobar" }
        expect(response).to render_template :new
      end
    end
  end

  describe "#destroy" do
    let(:user) { create(:user) }

    before do
      session[:user_id] = user.id
    end

    it "destroys the session" do
      delete :destroy
      expect(session[:user_id]).to be_nil
    end

    it "redirects to the main page" do
      delete :destroy
      expect(response).to redirect_to "/"
    end
  end
end
