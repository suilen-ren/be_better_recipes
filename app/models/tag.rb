class Tag < ApplicationRecord
  has_many :recipes, dependent: :destroy

end
