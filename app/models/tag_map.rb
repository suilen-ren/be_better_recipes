class TagMap < ApplicationRecord
  belongs_to :tag_map
  belongs_to :recipe

  validates :recipe_id, presence: true
  validates :tag_id ,presence: true
end
