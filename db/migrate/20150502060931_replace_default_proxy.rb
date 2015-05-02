class ReplaceDefaultProxy < ActiveRecord::Migration
  def change
    change_column :accounts, :proxy, :string , default: "50.2.15.123"
  end
end
