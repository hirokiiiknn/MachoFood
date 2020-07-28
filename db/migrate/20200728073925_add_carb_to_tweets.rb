class AddCarbToTweets < ActiveRecord::Migration[6.0]
  def change
    add_column :tweets, :carb, :integer
  end
end
