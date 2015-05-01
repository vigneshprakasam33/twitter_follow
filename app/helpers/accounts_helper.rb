module AccountsHelper
  def twitter_client(user)
    if Rails.env != "development" and !self.account.proxy.blank?
      proxy = {
          host: user.proxy,
          port: 3128
      }
    end

    client = Twitter::REST::Client.new do |config|
      config.consumer_key = "VcIWuB5KjBuVe4a6Guuy6wOFF"
      config.consumer_secret = "OhhaHaRG5y0e5md3Ci3wcnX6aQNDm4Qm8k604aDL0gAE7Cbj6a"
      config.access_token = user.access_token
      config.access_token_secret = user.access_secret
      config.proxy = proxy if proxy
    end
    client
  end
end
