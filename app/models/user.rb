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
  # ====================自分がフォローしているユーザーとの関連 ===================================
  #フォローする側のUserから見て、フォローされる側のUserを(中間テーブルを介して)集める。なので親はfollowing_id(フォローする側)
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  # 中間テーブルを介して「follower」モデルのUser(フォローされた側)を集めることを「followings」と定義
  has_many :followings, through: :active_relationships, source: :follower
  # ========================================================================================

  # ====================自分がフォローされるユーザーとの関連 ===================================
  #フォローされる側のUserから見て、フォローしてくる側のUserを(中間テーブルを介して)集める。なので親はfollower_id(フォローされる側)
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  # 中間テーブルを介して「following」モデルのUser(フォローする側)を集めることを「followers」と定義
  has_many :followers, through: :passive_relationships, source: :following
  # =======================================================================================
  def followed_by?(user)
    # 今自分(引数のuser)がフォローしようとしているユーザー(レシーバー)がフォローされているユーザー(つまりpassive)の中から、引数に渡されたユーザー(自分)がいるかどうかを調べる
    passive_relationships.find_by(following_id: user.id).present?
  end

  # コールバック関数（facebook, googleのsns認証）
  # def self.without_sns_data(auth)
  #   user = User.where(email: auth.info.email).first

  #     if user.present?
  #       sns = SnsCredential.create(
  #         uid: auth.uid,
  #         provider: auth.provider,
  #         user_id: user.id
  #       )
  #     else
  #       user = User.new(
  #         nickname: auth.info.name,
  #         email: auth.info.email,
  #       )
  #       sns = SnsCredential.new(
  #         uid: auth.uid,
  #         provider: auth.provider
  #       )
  #     end
  #     return { user: user ,sns: sns}
  #   end

  #  def self.with_sns_data(auth, snscredential)
  #   user = User.where(id: snscredential.user_id).first
  #   unless user.present?
  #     user = User.new(
  #       nickname: auth.info.name,
  #       email: auth.info.email,
  #     )
  #   end
  #   return {user: user}
  #  end

  #  def self.find_oauth(auth)
  #   uid = auth.uid
  #   provider = auth.provider
  #   snscredential = SnsCredential.where(uid: uid, provider: provider).first
  #   if snscredential.present?
  #     user = with_sns_data(auth, snscredential)[:user]
  #     sns = snscredential
  #   else
  #     user = without_sns_data(auth)[:user]
  #     sns = without_sns_data(auth)[:sns]
  #   end
  #   return { user: user ,sns: sns}
  # end
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end
end
