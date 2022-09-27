class User::HomesController < ApplicationController
  def top
    @recipes = Recipe.where(id: Favorite.group(:recipe_id).order('count(recipe_id) desc').pluck(:recipe_id)).limit(4)
  end

  def about
  end
end
