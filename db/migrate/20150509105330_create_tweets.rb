class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.text :status
      t.string :picture

      t.timestamps
    end
  end
end
