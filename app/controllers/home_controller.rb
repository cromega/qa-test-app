class HomeController < ApplicationController
  def index
    @user = User.find_by(id: session[:user_id])

    render :index
  end
end
