class ApplicationController < ActionController::Base
  before_action :set_q

  private
  def reject_guest_user
    if current_user.guest_user?
      flash[:notice] = "ゲスト機能ではご利用いただけません ログインまたは会員登録をお願いいたします"
      return redirect_back(fallback_location: root_path)
    end
  end

  def after_sign_in_path_for(resource)
    case resource
    when User
      mypages_path
    when Admin
      admin_root_path
    end
  end

  def after_sign_out_path_for(resource)
    root_path
  end


  def verify_correct_user(resource)
    unless resource.user_id == current_user.id
      flash[:alert] = "アクセス権限がありません"
      redirect_back(fallback_location: root_path)
    end
  end


  def set_q
    @q = Recipe.ransack(params[:q])
  end
end
