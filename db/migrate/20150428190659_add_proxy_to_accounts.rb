class AddProxyToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :proxy, :string , default: "50.2.15.72"
  end
end
