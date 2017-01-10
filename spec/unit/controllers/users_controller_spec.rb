require 'rails_helper'

describe UsersController, type: :controller do
  describe "#new" do
    it "renders the new user page" do
      get :new

      expect(response).to render_template :new
    end
  end

  describe "#create" do
    context "when the user params are valid" do
      before do
        post :create, params: {
          user: { username: "test", email: "test@test", password: "pw", password_confirmation: "pw" }
        }
      end

      it "creates the user" do
        expect(User.count).to be 1
      end

      it "redirects to the main page" do
        expect(response).to redirect_to "/"
      end
    end

    context "when the user params are invalid" do
      before do
        post :create, params: {
          user: { username: "", email: "", password: "", password_confirmation: "" }
        }
      end

      it "does not create the user" do
        expect(User.count).to be 0
      end

      it "rerenders the new user page" do
        expect(response).to render_template :new
      end
    end
  end

  describe "#edit" do
    let(:user) { create(:user) }

    before do
      log_in(user)
    end

    it "renders the profile settings" do
      get :edit, params: { id: user.id }

      expect(response).to render_template :edit
    end
  end

  describe "#update" do
    let(:user) { create(:user, username: "oldusername") }

    before do
      log_in(user)
    end

    context "when the user does not change the password" do
      it "updates the user" do
        patch :update, params: {
          id: user.id, user: { username: "newusername", password: "", password_confirmation: "" }
        }

        expect(user.reload.username).to eq "newusername"
      end

      it "does not change the password" do
        patch :update, params: {
          id: user.id, user: { username: "newusername", password: "", password_confirmation: "" }
        }

        expect(user.password).to eq user.reload.password
      end

      it "renders the profile page" do
        patch :update, params: {
          id: user.id, user: { username: "newusername", password: "", password_confirmation: "" }
        }

        expect(response).to render_template :edit
      end
    end

    context "when the user changes the password" do
      it "updates the user" do
        patch :update, params: {
          id: user.id, user: { username: "newusername", password: "foobar", password_confirmation: "foobar" }
        }

        expect(user.reload.username).to eq "newusername"
      end

      it "renders the profile page" do
        patch :update, params: {
          id: user.id, user: { username: "newusername" }
        }

        expect(response).to render_template :edit
      end
    end

    context "when the user can't be updated" do
      let(:invalid_username) { "" }
      it "rerenders the edit page" do
        patch :update, params: {
          id: user.id, user: { username: "" }
        }

        expect(response).to render_template :edit
      end
    end
  end
end
