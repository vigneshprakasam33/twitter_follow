class Celebrity < ActiveRecord::Base
  has_many :followers
  belongs_to :account

  validates_uniqueness_of :handle
end
