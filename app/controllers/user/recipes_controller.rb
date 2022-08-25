class User::RecipesController < ApplicationController
  def index
  end

  def show
  end

  def new
    @recipe = Recipe.new
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id

    @recipe.save
    if @recipe.save
      redirect_to recipes_path
      tag_list = params[:recipe][:tag_name].split(",")
      @recipe.save_recipes(tag_list)
    end
  end

  private
  def recipe_params
    params.require(:recipe).permit(:title,:feature,:making,:permit_user)
  end
end
