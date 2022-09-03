class User::MypagesController < ApplicationController
  def show
    favorites = Favorite.where(user_id: current_user.id).pluck(:recipe_id)
    @fav_recipes = Recipe.viewable.where(id: favorites).limit(4)
    @my_recipes = Recipe.viewable.where(user_id: current_user.id).limit(4)
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
end
