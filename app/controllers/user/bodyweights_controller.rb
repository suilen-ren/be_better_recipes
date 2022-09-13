class User::BodyweightsController < ApplicationController
  def update
    bodyweight = Bodyweight.find(params[:id])
    if bodyweight.update(bodyweight_params)
      flash[:notice] = "体重を変更しました"
      redirect_to edit_mypages_path
    else
      flash[:alert] = "入力内容を確認してください"
      redirect_to edit_mypages_path
    end
  end

  private
  def bodyweight_params
    params.require(:bodyweight).permit(:weight)
  end
end
