class User::TipsController < ApplicationController
  before_action :authenticate_user!

  def about_diet
  end
end
