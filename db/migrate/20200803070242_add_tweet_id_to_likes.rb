class AddTweetIdToLikes < ActiveRecord::Migration[6.0]
  def change
    add_column :likes, :tweet_id, :integer
  end
end
