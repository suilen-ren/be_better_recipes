class User::MypagesController < ApplicationController
  def show
    favorites = Favorite.where(user_id: current_user.id).pluck(:recipe_id)
    @fav_recipes = Recipe.viewable.where(id: favorites).limit(4)
    @my_recipes = Recipe.viewable.where(user_id: current_user.id).limit(4)
    @bodyweights = current_user.bodyweights.all
    @bodyweight = Bodyweight.all
  end
  
  def create
    @bodyweight = Bodyweight.new(bodyweight_params)
    @bodyweight.user_id = current_user.id
    if current_user.bodyweights.last.created_at.to_date == Date.today
      flash[:alert] = "体重は一日に一度保存できます"
      redirect_to my_pages_path
    else
      if @bodyweight.save
        flash[:notice] = "今日の体重を保存しました"
        redirect_to my_pages_
      else
        flash
      
  end

  def edit
  end

  def recipes
    @recipes = Recipe.viewable.where(user_id: current_user.id).page(params[:page]).per(12)
  end

  def confirm
  end

  def update
  end

  def withdraw
  end

  def favorite
    favorites = Favorite.where(user_id: current_user.id).pluck(:recipe_id)
    @recipes = Recipe.viewable.where(id: favorites).page(params[:pages]).per(12)
  end
  
  private
  
  def bodyweight_params
    params.require(:bodyweight).permit(:weight)
  end
end
