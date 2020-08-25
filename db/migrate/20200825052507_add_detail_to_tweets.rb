class AddDetailToTweets < ActiveRecord::Migration[6.0]
  def change
    add_column :tweets, :detail, :string
  end
end
