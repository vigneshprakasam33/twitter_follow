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
      config.consumer_key = "GRLlE3JqMPJQP0xerXM6ucmKF"
      config.consumer_secret = "twzSlJAd2dqh7QyVMHIK4q0NvbD8xyWmZgVKLq7LSmJc6ouuHQ"
      config.access_token = account.access_token
      config.access_token_secret = account.access_secret
      config.proxy = proxy  if proxy
    end

    if self.tweet.picture  and self.tweet.picture.current_path
      #tweet with picture
      client.update_with_media(self.tweet.status, open(self.tweet.picture.current_path))
    else
      #normal tweet
      client.update(self.tweet.status)
    end

    self.update :posted => true

    logger.info "Tweet posted=======>" + self.account.name
  end
  
  
end
