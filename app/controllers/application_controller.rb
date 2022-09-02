class ApplicationController < ActionController::Base
  before_action :set_q

  private
  def set_q
    @q = Recipe.ransack(params[:q])
  end
end
