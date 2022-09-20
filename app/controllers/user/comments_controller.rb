class User::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :reject_guest_user

  def create
    recipe = Recipe.find(params[:recipe_id])
    comment = current_user.comments.new(comment_params)
    comment.recipe_id = recipe.id
    if comment.save
      redirect_to recipe_path(recipe.id)
    else
      flash[:alert] = "コメントが入力されていません"
      redirect_back(fallback_location: root_path )
    end

  end
  def destroy
    comment = Comment.find(params[:id])
    verify_correct_user(comment)
    comment.destroy
    redirect_to recipe_path(params[:recipe_id])


  end

  private

  def comment_params
    params.require(:comment).permit(:comment_text)
  end
end
