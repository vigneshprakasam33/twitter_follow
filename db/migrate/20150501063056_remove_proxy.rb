class RemoveProxy < ActiveRecord::Migration
  def change
    Account.all.each do |a|
      next if a.id == 9
      a.update(:proxy => nil)
    end
  end
end
