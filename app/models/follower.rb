class Follower < ActiveRecord::Base
  belongs_to :celebrity

  validates_presence_of :uid
  validates_uniqueness_of :uid , scope: :celebrity_id
end
