class RemoveBrazzers < ActiveRecord::Migration
  def change
    a = Follower.where(:celebrity_id => 1).pluck(:id)
    Follower.where(:celebrity_id => 1).destroy_all
    AutoFollow.where(:follower_id => a).destroy_all
  end
end
