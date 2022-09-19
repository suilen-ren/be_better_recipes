class Admin::RecipesController < ApplicationController
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

  private
  def recipe_params
    params.require(:recipe).permit(:permit_admin)
  end

end
