class UsersController < ApplicationController
  before_filter :authenticate, except: %i(new create)

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)

    if user.save
      flash[:notice] = "User has been created successfully!"
      redirect_to "/"
    else
      @user = User.new
      flash.now[:errors] = user.errors.full_messages
      render :new
    end
  end

  def edit
    render :edit
  end

  def update
    if current_user.update(user_params)
      flash.now[:success] = "User details updated"
      render :edit
    else
      flash.now[:errors] = current_user.errors.full_messages
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
