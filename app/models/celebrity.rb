class Celebrity < ActiveRecord::Base
  has_many :followers
  belongs_to :account
end
