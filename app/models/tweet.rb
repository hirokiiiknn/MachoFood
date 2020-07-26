class Tweet < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :text,:image,:title, presence: true
  belongs_to :user
  has_many :comments

  def self.search(search)
    if search 
      Tweet.where('text LIKE(?)', "%#{search}%")
    else
      Tweet.all
    end
  end
end
