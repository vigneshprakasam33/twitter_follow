class CreateAutoFollows < ActiveRecord::Migration
  def change
    create_table :auto_follows do |t|
      t.integer :account_id
      t.integer :follower_id
      t.boolean :followed
      t.boolean :follow_back

      t.timestamps
    end
  end
end
