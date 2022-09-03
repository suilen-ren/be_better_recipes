class User::RecipesController < ApplicationController
  before_action :authenticate_user!

  def index
    @recipes = Recipe.viewable.page(params[:pages]).per(10)
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipe_tags = @recipe.tags
    @comment = Comment.new
    @comments = @recipe.comments.all

  end

  def new
    @recipe = Recipe.new
  end

  def edit
    @recipe = Recipe.find(params[:id])
    @tag_list = @recipe.tags.pluck(:name).join(',')
  end

  def update
    @recipe = Recipe.find(params[:id])
    tag_list = params[:recipe][:tag_name].split(",")
    if @recipe.update(recipe_params)
      @recipe.save_recipes(tag_list)
      flash[:notice] = "変更を保存しました"
      redirect_to recipe_path(@recipe.id)
    else
      render :edit
    end

  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id

    if @recipe.save
      redirect_to recipes_path
      tag_list = params[:recipe][:tag_name].split(",")
      @recipe.save_recipes(tag_list)
    else
      render :new
    end
  end
  def search
    @recipes = @q.result.page(params[:pages]).per(10)
  end


  private
  def recipe_params
    params.require(:recipe).permit(:title,:feature,:making,:permit_user,:image)
  end
end
