class Celebrity < ActiveRecord::Base
  has_many :followers
end
