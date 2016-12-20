require 'rails_helper'

describe UsersController, type: :controller do
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
end
