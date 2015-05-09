class AddIndexes < ActiveRecord::Migration
  def change
    add_index :auto_follows, :account_id , :name => "account_index"
    add_index :auto_follows, :follower_id , :name => "follower_index"
    add_index :auto_follows, [:followed, :inactive_user] , :name => "next_user_index"
  end
end
