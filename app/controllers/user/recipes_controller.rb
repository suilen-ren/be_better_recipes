class User::RecipesController < ApplicationController
  before_action :authenticate_user!
  # before_action :reject_guest_user ,except: [:index,:show]

  def index
    @recipes = Recipe.viewable.page(params[:pages]).per(10)
  end

  def show

    @recipe = Recipe.find(params[:id])
    @recipe_tags = @recipe.tags
    @comment = Comment.new
    @comments = @recipe.comments.all
    if @recipe.permit_admin == false
      flash[:notice] = "このレシピは管理者により非表示にされています。"
    end
  end

  def new
    @recipe = Recipe.new
    reject_guest_user
  end

  def edit
    @recipe = Recipe.find(params[:id])
    verify_correct_user(@recipe)
    @tag_list = @recipe.tags.pluck(:name).join(',')
  end

  def update
    @recipe = Recipe.find(params[:id])
    verify_correct_user(@recipe)
    tag_list = params[:recipe][:tag_name].split(",")
    if @recipe.update(recipe_params)
      @recipe.save_recipes(tag_list)
      flash[:notice] = "変更を保存しました"
      redirect_to recipe_path(@recipe.id)
    else
      redirect_back(fallback_location: root_path)
    end

  end

  def destroy
    @recipe = Recipe.find(params[:id])
    verify_correct_user(@recipe)
    @recipe.destroy
    redirect_to recipes_path, notice: "レシピを削除しました"
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id

    if @recipe.save
      redirect_to recipe_path(@recipe.id) ,notice: "新規レシピを保存しました。"
      tag_list = params[:recipe][:tag_name].split(",")
      @recipe.save_recipes(tag_list)
    else
      flash[:notice] = "すべての項目を入力してから保存してください。または文字数制限を超えていないか確認してください"
      redirect_back(fallback_location: root_path)
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
