class AccountsTweet < ActiveRecord::Base
  belongs_to :account
  belongs_to :tweet
  #after_create :post_tweet


  def post_tweet
    if Rails.env != "development" and !account.proxy.blank?
      proxy = {
          host: account.proxy,
          port: 3128
      }
    end

    client = Twitter::REST::Client.new do |config|
      config.consumer_key = "VcIWuB5KjBuVe4a6Guuy6wOFF"
      config.consumer_secret = "OhhaHaRG5y0e5md3Ci3wcnX6aQNDm4Qm8k604aDL0gAE7Cbj6a"
      config.access_token = account.access_token
      config.access_token_secret = account.access_secret
      config.proxy = proxy  if proxy
    end

    client.update_with_media(self.tweet.status, open(self.tweet.picture.current_path))
    self.update :posted => true

    logger.debug "Tweet posted=======>" + self.account.name
  end
  
  
end
