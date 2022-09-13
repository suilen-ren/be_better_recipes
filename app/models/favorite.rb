class Favorite < ApplicationRecord
  belongs_to :recipe
  belongs_to :user
  
  validates :user_id, presence: true
  validates :recipe_id, presence: true
end
