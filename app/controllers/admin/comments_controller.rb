class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @recipe = Recipe.find(params[:recipe_id])
    @comments = @recipe.comments.all.page(params[:pages]).per(5)
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    Comment.find(params[:id]).destroy
    redirect_to admin_recipe_comments_path(@recipe.id) , notice: "コメントを削除しました"
  end
end
