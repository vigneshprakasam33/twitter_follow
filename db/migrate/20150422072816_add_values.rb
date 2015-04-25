class AddValues < ActiveRecord::Migration
  def change
    Account.create(:uid => "3193536466" , :name => "smooth_claire" , :pass => "Billa123")
  end
end
