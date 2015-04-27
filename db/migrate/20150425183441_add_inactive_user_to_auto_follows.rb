class AddInactiveUserToAutoFollows < ActiveRecord::Migration
  def change
    add_column :auto_follows, :inactive_user, :boolean
  end
end
