class CreateFollowers < ActiveRecord::Migration
  def change
    create_table :followers do |t|
      t.string :uid
      t.integer :celebrity_id
      t.string :handle

      t.timestamps
    end
  end
end
