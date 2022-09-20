class Admin::RecipesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @recipes = Recipe.all.page(params[:pages]).per("15")
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipe_tags = @recipe.tags
  end

  def update
    @recipe = Recipe.find(params[:id])
    @recipe.update(recipe_params)
    redirect_to admin_recipe_path(@recipe.id),notice: "変更を保存しました"
  end

  def search
    @recipes = @q.result.page(params[:pages]).per(15)
  end

  private
  def recipe_params
    params.require(:recipe).permit(:permit_admin)
  end

end
