class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :recipes,dependent: :destroy
  has_many :bodyweights,dependent: :destroy
  has_many :comments ,dependent: :destroy
  has_many :favorites, dependent: :destroy

  def balance
    minus = self.bodyweights.last.weight - self.target_weight
    if minus >=  0
      return minus
    else
      return (-1 * minus)
    end
  end
end
