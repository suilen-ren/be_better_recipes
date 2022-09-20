class User::GoalsController < ApplicationController
  before_action :authenticate_user!
  before_action :reject_guest_user

  def show
    @user = current_user
  end


  def update
    @user = current_user
    if params[:user][:target_date].nil? || params[:user][:target_weight].blank?
      flash[:notice] = "目標の日付と体重両方を登録する必要があります"
      redirect_back(fallback_location: root_path)
    elsif params[:user][:target_date].to_date.before? Date.today
      flash[:notice] = "今日以降の日付を登録してください"
      redirect_back(fallback_location: root_path)
    else
      @user.update(target_params)
      redirect_to mypages_path,notice: "目標を保存しました"
    end
  end

  private
  def target_params
    params.require(:user).permit(:target_date,:target_weight)
  end
end
