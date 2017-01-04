class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authenticate
    flash[:notice] = "The requested page was not found"
    redirect_to "/" unless current_user
  end

  def current_user
    @user ||= User.find_by(id: session[:user_id])
  end
end
