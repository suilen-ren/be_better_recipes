class User::TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id])
    @recipes = @tag.recipes.viewable.page(params[:pages]).per(10)
  end
end
