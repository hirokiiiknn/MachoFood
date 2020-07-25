class Tweet < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :text,:image,:title, presence: true
  belongs_to :user
end
