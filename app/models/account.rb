class Account < ActiveRecord::Base
  has_many :auto_follows
  has_many :celebrities
  has_many :accounts_tweets
  has_many :tweets , :through => :accounts_tweets


  def self.from_omniauth(auth)
    acc = where(auth.slice("uid")).first

    if acc.blank? or acc.access_token.blank? or acc.access_secret.blank?
      create_from_omniauth(auth)
    end
  end

  def self.create_from_omniauth(auth)
    create do |user|
      user.uid = auth["uid"]
      user.name = auth["info"]["nickname"]
      user.access_token = auth["credentials"]["token"]
      user.access_secret = auth["credentials"]["secret"]
    end
  end

end
