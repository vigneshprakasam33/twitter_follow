class ModifyProxy < ActiveRecord::Migration
  def change
    change_column :accounts, :proxy, :string , default: "108.62.124.86"
  end
end
