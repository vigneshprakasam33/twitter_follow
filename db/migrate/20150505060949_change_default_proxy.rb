class ChangeDefaultProxy < ActiveRecord::Migration
  def change
    change_column :accounts, :proxy, :string , default: "173.44.219.155"
  end
end
