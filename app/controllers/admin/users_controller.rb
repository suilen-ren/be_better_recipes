class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @users = User.all.page(params[:page]).per(15)
  end

  def show
    @user = User.find(params[:id])

  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to admin_user_path(@user.id), notice: "ステータスを変更しました"
  end

  def destroy
  end
  def recipe
  end

  private
  def user_params
    params.require(:user).permit(:is_active)
  end
end
