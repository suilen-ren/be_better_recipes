class User::BodyweightsController < ApplicationController
  before_action :authenticate_user!
  before_action :reject_guest_user

  def update
    bodyweight = Bodyweight.find(params[:id])
    verify_correct_user(bodyweight)
    if bodyweight.update(bodyweight_params)
      flash[:notice] = "体重を変更しました"
      redirect_to edit_mypages_path
    else
      flash[:alert] = "入力内容を確認してください"
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def bodyweight_params
    params.require(:bodyweight).permit(:weight)
  end
end
