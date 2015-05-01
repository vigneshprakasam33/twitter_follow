class AutoFollow < ActiveRecord::Base
  belongs_to :follower
  belongs_to :account


  def unfollow

    if Rails.env == "staging"
      proxy = {
          host: self.account.proxy,
          port: 3128
      }
    end



    client = Twitter::REST::Client.new do |config|
      config.consumer_key = "VcIWuB5KjBuVe4a6Guuy6wOFF"
      config.consumer_secret = "OhhaHaRG5y0e5md3Ci3wcnX6aQNDm4Qm8k604aDL0gAE7Cbj6a"
      config.access_token = self.account.access_token
      config.access_token_secret = self.account.access_secret
      config.proxy = proxy if proxy
    end

    begin
      user = client.user(self.follower.uid.to_i)

      #follow
      client.unfollow(user)

    rescue Twitter::Error::TooManyRequests => error
      # NOTE: Your process could go to sleep for up to 15 minutes but if you
      # retry any sooner, it will almost certainly fail with the same exception.
      sleep error.rate_limit.reset_in + 1
      retry
    rescue Twitter::Error => error
      logger.debug error.message
      #other exceptions
      #else

    end


    #next job
    jobs = self.account.auto_follows.where(:followed => true)
    self.destroy

    if jobs.count > 0
      jobs.first.delay(:run_at => Time.now + 1.minute).unfollow
    end


  end

  def follow_start

    if Rails.env == "staging"
      proxy = {
          host: self.account.proxy,
          port: 3128
      }
    end
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = "VcIWuB5KjBuVe4a6Guuy6wOFF"
      config.consumer_secret = "OhhaHaRG5y0e5md3Ci3wcnX6aQNDm4Qm8k604aDL0gAE7Cbj6a"
      config.access_token = self.account.access_token
      config.access_token_secret = self.account.access_secret
      config.proxy = proxy   if proxy
    end

    begin
      if self.follower and self.follower.uid
        user = client.user(self.follower.uid.to_i)
      else
        self.update(:inactive_user => true)
        #  bogus user
        return self.account.auto_follows.where(:followed => nil, :inactive_user => nil).first.follow_start
      end

      if user.followers_count < 100 #or user.tweets_count < 100

        logger.debug "======INACTIVE USER======>" + user.followers_count.to_s + " , " + user.tweets_count.to_s

        self.update(:inactive_user => true)
        return self.account.auto_follows.where(:followed => nil, :inactive_user => nil).first.follow_start

      end

      #just fyi
      #self.follower.update(:handle => user.handle)

      #follow
      client.follow(user, true)

    rescue Twitter::Error::TooManyRequests => error
      # NOTE: Your process could go to sleep for up to 15 minutes but if you
      # retry any sooner, it will almost certainly fail with the same exception.
      sleep error.rate_limit.reset_in + 1
      retry
    rescue Twitter::Error => error
      logger.debug error.message
      #other exceptions
      #else
    end


    self.update(:followed => true)

    #next job
    jobs = self.account.auto_follows.where(:followed => nil)
    if jobs.count > 0
      jobs.first.delay(:run_at => Time.now + 1.minute).follow_start
    end

  end


end
