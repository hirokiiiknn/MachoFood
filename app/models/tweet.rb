class Tweet < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :text,:image,:title, presence: true
  belongs_to :user
  has_many :comments
  has_many :likes, dependent: :destroy
  

  def self.search(search)
    if search 
      Tweet.where('text LIKE(?)', "%#{search}%")
    else
      Tweet.all
    end
  end

  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end
end
