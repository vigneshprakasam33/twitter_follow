class Account < ActiveRecord::Base
  has_many :auto_follows
  has_many :celebrities
  has_many :accounts_tweets
  has_many :tweets , :through => :accounts_tweets


  def self.from_omniauth(auth)

    acc = where(auth.slice("uid")).first

    if acc.blank?
      return create_from_omniauth(auth)
    elsif acc.access_token.blank? or acc.access_secret.blank?
      return update_from_omniauth(acc,auth)
    end

    logger.debug acc
    acc
  end

  def self.create_from_omniauth(auth)
    create do |user|
      user.uid = auth["uid"]
      user.name = auth["info"]["nickname"]
      user.access_token = auth["credentials"]["token"]
      user.access_secret = auth["credentials"]["secret"]
    end
  end

  def self.update_from_omniauth(acc,auth)
    acc.update(:access_token => auth["credentials"]["token"] , :access_secret => auth["credentials"]["secret"])
    acc
  end

end
