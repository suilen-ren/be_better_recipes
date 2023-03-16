class User::FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :reject_guest_user

  def create
    recipe = Recipe.find(params[:recipe_id])
    favorite = current_user.favorites.new(recipe_id: recipe.id)
    favorite.save
    # redirect_to recipe_path(recipe),notice: "レシピをお気に入りに追加しました"
  end

  def destroy
    recipe = Recipe.find(params[:recipe_id])
    favorite = current_user.favorites.find_by(recipe_id: recipe.id)
    favorite.destroy
    # redirect_to recipe_path(recipe),notice: "レシピをお気に入りから削除しました"
  end


end
