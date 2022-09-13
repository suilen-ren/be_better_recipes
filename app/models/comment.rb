class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  
  validates :user_id, presence: true
  validates :recipe_id, presence: true
  validates :comment_text, length: {maximum: 100},presence: true
end
