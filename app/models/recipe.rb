class Recipe < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :tag_map
  has_one_attached :image
end
