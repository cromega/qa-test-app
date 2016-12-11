require "digest/sha1"

class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.find_by(username: params[:username], password: Digest::SHA1.hexdigest(params[:password]))

    if user
      session[:user_id] = user.id
      redirect_to "/"
    else
      flash.now[:error] = "User not found"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to "/"
  end

  private

  def session_params
    params.require(:username, :password)
  end
end
