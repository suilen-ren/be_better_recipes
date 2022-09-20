class ApplicationController < ActionController::Base
  before_action :set_q

  def reject_guest_user
    if current_user.guest_user?
      flash[:notice] = "ゲスト機能ではご利用いただけません 会員登録をお願いいたします"
      redirect_back(fallback_location: root_path)
    end
  end

  def verify_correct_user(resource)
    unless resource.user_id == current_user.id
      flash[:alert] = "アクセス権限がありません"
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def set_q
    @q = Recipe.ransack(params[:q])
  end
end
