class User::MypagesController < ApplicationController
  before_action :authenticate_user!
  before_action :reject_guest_user

  def show
    favorites = Favorite.where(user_id: current_user.id).pluck(:recipe_id)
    @fav_recipes = Recipe.viewable.where(id: favorites).limit(4)
    @my_recipes = Recipe.where(user_id: current_user.id).limit(4)
    @bodyweights = current_user.bodyweights.all
    @bodyweight = Bodyweight.all
  end

  def create
    @bodyweight = Bodyweight.new(bodyweight_params)
    @bodyweight.user_id = current_user.id
    if current_user.bodyweights.exists?(created_at: Time.zone.now.all_day)
      flash[:alert] = "今日の体重はすでに登録されています。訂正は会員情報編集から行えます。"
      redirect_to mypages_path
    else
      if @bodyweight.save
        flash[:notice] = "今日の体重を保存しました"
        redirect_to mypages_path
      else
        flash[:notice] = "有効な数字を入力してください"
        redirect_back(fallback_location: root_path)
      end
    end
  end

  def edit
    @user = current_user
    @bodyweights = current_user.bodyweights.limit(4).order('id DESC')
  end

  def recipes
    @recipes = Recipe.viewable.where(user_id: current_user.id).page(params[:page]).per(12)
  end

  def confirm
  end

  def update
    @user = current_user
    @user.update(user_params)
    flash[:notice] = "登録情報を保存しました"
    redirect_to mypages_path
  end

  def goal
  end

  def withdraw
    @user = current_user
    @user.update(is_active: false)
    binding.pry
    reset_session
    redirect_to root_path, notice: "退会処理が完了しました。"

  end

  def favorite
    favorites = Favorite.where(user_id: current_user.id).pluck(:recipe_id)
    @recipes = Recipe.viewable.where(id: favorites).page(params[:pages]).per(12)
  end

  private
  def user_params
    params.require(:user).permit(:email,:name,:birthday,:gender)
  end

  def bodyweight_params
    params.require(:bodyweight).permit(:weight)
  end
end
