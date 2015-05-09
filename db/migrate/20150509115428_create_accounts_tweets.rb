class CreateAccountsTweets < ActiveRecord::Migration
  def change
    create_table :accounts_tweets do |t|
      t.integer :account_id
      t.integer :tweet_id

      t.timestamps
    end
  end
end
