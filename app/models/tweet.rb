class Tweet < ActiveRecord::Base
  mount_uploader :picture, PictureUploader
  has_many :accounts_tweets
  has_many :accounts , :through => :accounts_tweets
  accepts_nested_attributes_for :accounts_tweets

end
