class ApplicationController < ActionController::Base
  before_action :set_q

  def reject_guest_user
    if current_user.email == "guest@example.com"
      flash[:notice] = "ゲスト機能ではご利用いただけません 会員登録をお願いいたします"
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def set_q
    @q = Recipe.ransack(params[:q])
  end
end
