class AutoFollow < ActiveRecord::Base
  belongs_to :follower
  belongs_to :account

  def follow_start

    if self.account.name == "smooth_claire"
      client = Twitter::REST::Client.new do |config|
        config.consumer_key = "6zEMTtOsh1FrUPaCRn34JEgA7"
        config.consumer_secret = "PWsk0Sq7uCaNyurq8B3Jwchx9LS964vmuzhRTp6TtfzX9FFP7S"
        config.access_token = "3193536466-wabyqg3GmuMhjELM5zlCttKJ1gIH6Hl0rWZOk2g"
        config.access_token_secret = "Df0GFxYnHWR3AGaGbOCNqsVvhrYhRBMGMXu5MP0Y0WFd3"
      end
    else
      #  auto attend
      client = Twitter::REST::Client.new do |config|
        config.consumer_key        = "VcIWuB5KjBuVe4a6Guuy6wOFF"
        config.consumer_secret     = "OhhaHaRG5y0e5md3Ci3wcnX6aQNDm4Qm8k604aDL0gAE7Cbj6a"
        config.access_token        = "2939896867-Cj5trbDzoa4BKOCsS5nP2zxijOeseBKfYGC2XOV"
        config.access_token_secret = "56I5HhoNiClJASBQPIstnxbRxTM1VSILopduEHb8FG3Ti"
      end
    end

    begin

      user = client.user(self.follower.uid.to_i)
      if user.followers_count < 100 or user.tweets_count < 100

        logger.debug "======INACTIVE USER======>" + user.followers_count.to_s + " , " + user.tweets_count.to_s

        self.update(:inactive_user => true)
        return self.account.auto_follows.where(:followed => nil , :inactive_user => nil).first.follow_start

      end

      #just fyi
      self.follower.update(:handle => user.handle)

      #follow
      client.follow(user, true)

    rescue Twitter::Error::TooManyRequests => error
      # NOTE: Your process could go to sleep for up to 15 minutes but if you
      # retry any sooner, it will almost certainly fail with the same exception.
      sleep error.rate_limit.reset_in + 1
      retry
    end


    self.update(:followed => true)

    #next job
    jobs = self.account.auto_follows.where(:followed => nil)
    if jobs.count > 0
      jobs.first.delay(:run_at => Time.now + 1.minute).follow_start
    end

  end


end
