class User::GoalsController < ApplicationController
  def show
    @user = current_user
  end


  def update
    @user = current_user
    if @user.update(target_params)
      redirect_to mypages_path
    else
      render :show
    end
  end

  private
  def target_params
    params.require(:user).permit(:target_date,:target_weight)
  end
end
