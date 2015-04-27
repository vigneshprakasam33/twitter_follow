class AddAccessTokenToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :access_token, :string
    add_column :accounts, :access_secret, :string
  end
end
