class CreateCelebrities < ActiveRecord::Migration
  def change
    create_table :celebrities do |t|
      t.string :uid
      t.string :handle
      t.string :category

      t.timestamps
    end
  end
end
