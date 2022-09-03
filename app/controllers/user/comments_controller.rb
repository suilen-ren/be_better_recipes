class User::CommentsController < ApplicationController
  def create
    recipe = Recipe.find(params[:recipe_id])
    comment = current_user.comments.new(comment_params)
    comment.recipe_id = recipe.id
    if comment.save
      redirect_to recipe_path(recipe.id)
    else
      flash[:alert] = "コメントが入力されていません"
      redirect_to recipe_path(recipe.id)
    end

  end
  def destroy
    Comment.find(params[:id]).destroy
    redirect_to recipe_path(params[:recipe_id])


  end

  private

  def comment_params
    params.require(:comment).permit(:comment_text)
  end
end
