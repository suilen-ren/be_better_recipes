class Recipe < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps
  has_one_attached :image

  validates :user_id, presence: true
  validates :image, presence: true
  validates :title,presence: true,length: {maximum: 20}
  validates :feature ,presence: true,length: {maximum: 300}
  validates :making ,presence: true,length: {maximum: 1000}
  validates :permit_user ,inclusion: {in: [true,false]}
  validates :permit_admin ,inclusion: {in: [true,false]}

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path),filename: 'no_image.jpg', content_type: 'image/jpeg')
    else
      image
    end
  end

  def save_recipes(save_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - save_tags
    new_tags = save_tags - current_tags

    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name: old_name)
    end

    new_tags.each do |new_name|
      post_tag = Tag.find_or_create_by(name: new_name )
      self.tags << post_tag
    end
  end



  def self.viewable
    p_user = Recipe.where(permit_user: true)
    return p_user.where(permit_admin: true)
  end

  def viewable?
    if self.permit_admin == true && self.permit_user == true
      return true
    else
      return false
    end
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

end
