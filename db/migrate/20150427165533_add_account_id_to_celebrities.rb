class AddAccountIdToCelebrities < ActiveRecord::Migration
  def change
    add_column :celebrities, :account_id, :integer
  end
end
