class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authenticate
    unless current_user
      flash[:error] = "The requested page was not found"
      redirect_to "/" unless current_user
    end
  end

  def current_user
    @user ||= User.find_by(id: session[:user_id])
  end
end
