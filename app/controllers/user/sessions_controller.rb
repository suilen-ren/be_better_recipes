# frozen_string_literal: true

class User::SessionsController < Devise::SessionsController
  before_action :reject_inactive_user, only: [:create]


  def guest_sign_in
    if user_signed_in?
      flash[:alert] = "すでにログインしています"
      redirect_to root_path
    else
      user= User.find_or_create_by!(email: 'guest@example.com') do |user|
        user.password = SecureRandom.urlsafe_base64
        user.name = "ゲスト"
        user.birthday = "2001-01-01"
        user.gender = "male"
      end
      sign_in user
      flash[:notice] = "ゲストユーザーとしてログインしました"
      redirect_to root_path
    end
  end

  def reject_inactive_user
    @user = User.find_by(email: params[:user][:email])
    if @user
      if @user.valid_password?(params[:user][:password]) && !@user.is_active
        redirect_to new_user_session_path, notice: "このメールアドレスを使用する場合、管理人にご連絡ください"
      end
    end
  end
  


  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
