class AddProteinToTweets < ActiveRecord::Migration[6.0]
  def change
    add_column :tweets, :protein, :integer
  end
end
