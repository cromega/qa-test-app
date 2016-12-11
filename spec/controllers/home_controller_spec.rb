require 'rails_helper'

describe HomeController, type: :controller do
  describe "#index" do
    render_views

    context "with user logged in" do
      before do
        user = User.create(username: "test", email: "test@test", password: "test")
        request.session[:user_id] = user.id
      end

      it "welcomes the user" do
        get :index
        expect(response).to render_template(partial: "_welcome")
      end
    end

    context "without user logged in" do
      it "renders the default main page" do
        get :index
        expect(response).to render_template(partial: "_not_logged_in")
      end
    end
  end
end
