class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :uid
      t.string :name
      t.string :pass

      t.timestamps
    end
  end
end
