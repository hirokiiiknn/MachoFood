class Like < ApplicationRecord

  belongs_to :tweet, counter_cache: :likes_count
  belongs_to :user
  validates :tweet_id, uniqueness: { scope: :user_id }
end
