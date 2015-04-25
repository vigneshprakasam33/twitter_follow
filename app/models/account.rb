class Account < ActiveRecord::Base
  has_many :auto_follows
end
