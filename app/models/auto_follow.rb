class AutoFollow < ActiveRecord::Base
  belongs_to :follower
  belongs_to :account

  validates_uniqueness_of :follower_id

  def unfollow(acc)

    if Rails.env != "development" and !acc.proxy.blank?
      proxy = {
          host: acc.proxy,
          port: 3128
      }
    end


    client = Twitter::REST::Client.new do |config|
      config.consumer_key = "fHD3Aicdej8kmbSNdmGKz8fMM"
      config.consumer_secret = "iBEfLL5P15u47LfZThraEJRFoCFMgr0qDyJrgOhooqqPGMXpSd"
      config.access_token = acc.access_token
      config.access_token_secret = acc.access_secret
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
    jobs = self.account.auto_follows.where(:followed => true, :inactive_user => nil)
    self.destroy

    if jobs.count > 0
      jobs.first.delay(:run_at => Time.now + 30.seconds).unfollow(acc)
    end


  end

  def follow_start(acc)

    if Rails.env != "development" and !acc.proxy.blank?
      proxy = {
          host: acc.proxy,
          port: 3128
      }
    end
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = "fHD3Aicdej8kmbSNdmGKz8fMM"
      config.consumer_secret = "iBEfLL5P15u47LfZThraEJRFoCFMgr0qDyJrgOhooqqPGMXpSd"
      config.access_token = acc.access_token
      config.access_token_secret = acc.access_secret
      config.proxy = proxy if proxy
    end

    begin
      if self.follower and self.follower.uid
        user = client.user(self.follower.uid.to_i)
      else
        self.update(:inactive_user => true)
        #  bogus user
        a = AutoFollow.where(:followed => nil, :inactive_user => nil).first
        a.update(:followed => true, :account_id => acc.id)
        return a.follow_start(acc)
      end

      if user.followers_count < 10 or user.followers_count > 9999 or user.friends_count > 9999 or user.friends_count < 10 or user.tweets_count < 10 or time_since_last_tweet(user) > 50

        logger.debug "======INACTIVE USER======>followers:" + user.followers_count.to_s + " , tweets:" + user.tweets_count.to_s

        self.update(:inactive_user => true)
        a = AutoFollow.where(:followed => nil, :inactive_user => nil).first
        a.update(:followed => true, :account_id => acc.id)
        return a.follow_start(acc)

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

    self.update(:followed => true, :account_id => acc.id)

    #next job
    jobs = AutoFollow.where(:followed => nil, :inactive_user => nil)
    if jobs.count > 0
      u = client.user(acc.name)
      jobs.first.update :followed => true

      #if follow limit threshold is reached, start unfollowing
      if u.friends_count < 1995
        jobs.first.delay(:run_at => Time.now + 30.seconds).follow_start(acc)
      else
        jobs = self.account.auto_follows.where(:followed => true, :inactive_user => nil)
        jobs.first.delay(:run_at => Time.now + 30.seconds).unfollow(acc)
      end

    end

  end


  private

  def time_since_last_tweet(user)
    (Date.current - user.tweet.created_at.to_date).to_i rescue 1000
  end


end
