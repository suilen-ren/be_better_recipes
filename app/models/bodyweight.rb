class Bodyweight < ApplicationRecord
  belongs_to :user
  
  
  validates :user_id ,presence: true
  validates :weight ,presence: true,numericality: {in: 40..100}
end
