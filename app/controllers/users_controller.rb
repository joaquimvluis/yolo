class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update]

  def index
    @users = User.all
    authorize @users

  end

  def edit
  end

  def update
    @user.update(user_params)
    redirect_to user_user_tasks_path(@user)
  end

  private

  def set_user
    @user = current_user
    authorize @user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :bio, :date_of_birth, :photo)
  end
end
