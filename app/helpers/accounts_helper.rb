module AccountsHelper
  def twitter_client(user)
    if Rails.env != "development" and !user.proxy.blank?
      proxy = {
          host: user.proxy,
          port: 3128
      }
    end

    client = Twitter::REST::Client.new do |config|
      config.consumer_key = "fHD3Aicdej8kmbSNdmGKz8fMM"
      config.consumer_secret = "iBEfLL5P15u47LfZThraEJRFoCFMgr0qDyJrgOhooqqPGMXpSd"
      config.access_token = user.access_token
      config.access_token_secret = user.access_secret
      config.proxy = proxy if proxy
    end
    client
  end
end
