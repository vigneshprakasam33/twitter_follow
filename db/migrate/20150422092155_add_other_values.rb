class AddOtherValues < ActiveRecord::Migration
  def change
    Celebrity.create(:handle => "Brazzers" ,:category => "adult")
  end
end
