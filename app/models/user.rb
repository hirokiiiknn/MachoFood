class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]
         
  has_many :tweets
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :like_tweets, through: :likes, source: :tweet
  validates :profile, length: { maximum: 250 }
  mount_uploader :image, ImageUploader

  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship",  dependent: :destroy
  has_many :following, through: :following_relationships
  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships

  #フォローしているかを確認するメソッド
  def following?(user)
    following_relationships.find_by(following_id: user.id)
  end

  #フォローするときのメソッド
  def follow(user)
    following_relationships.create!(following_id: user.id)
  end

  #フォローを外すときのメソッド
  def unfollow(user)
    following_relationships.find_by(following_id: user.id).destroy
  end

  # コールバック関数（facebook, googleのsns認証）
  def self.find_or_create_from_auth(auth)
    find_or_create_by(email: auth.info.email) do |user|
      user.password = Devise.friendly_token[0, 20]
      user.nickname = auth.info.name
      user.remote_image_url = auth.info.image
      user.profile = auth.info.description
      user.provider = auth.provider
      user.uid = auth.uid
    end
  end
end
