class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :recipes,dependent: :destroy
  has_many :bodyweights,dependent: :destroy
  has_many :comments ,dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :email , presence: true
  validates :name , presence: true , length: {minimum: 2,maximum:10}
  validates :birthday ,presence: true
  validates :gender ,inclusion: ["male","female"]
  validates :is_active ,inclusion: [true,false]

  def balance
    minus = self.bodyweights.last.weight - self.target_weight
    if minus >=  0
      return minus
    else
      return 0
    end
  end

  def show_gender
    if self.gender == "male"
      return "男性"
    elsif self.gender == "female"
      return "女性"
    end
  end

  def guest_user?
    if self.email == "guest@example.com"
      return true
    else
      return false
    end
  end
end
