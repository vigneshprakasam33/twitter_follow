class AddPostedToAccountsTweets < ActiveRecord::Migration
  def change
    add_column :accounts_tweets, :posted, :boolean
  end
end
