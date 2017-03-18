class UsersController < ApplicationController
  def index

  end

  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    @user = User.new user_params

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'signed up'
    else
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def update
    user_params = params.require(:user).permit(:first_name, :last_name, :email)
    @user = current_user

    if @user.update(user_params)
      redirect_to root_path(@user)
    else
      render :edit
    end
  end
end
