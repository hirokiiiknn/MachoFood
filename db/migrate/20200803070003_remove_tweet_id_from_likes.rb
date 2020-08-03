class RemoveTweetIdFromLikes < ActiveRecord::Migration[6.0]
  def change
    remove_column :likes, :tweet_id, :string
  end
end
