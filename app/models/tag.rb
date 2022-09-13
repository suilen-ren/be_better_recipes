class Tag < ApplicationRecord
  has_many :tag_maps ,dependent: :destroy ,foreign_key: 'tag_id'
  has_many :recipes ,through: :tag_maps
  
  validates :name, presence: true

end
