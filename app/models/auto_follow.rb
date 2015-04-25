class AutoFollow < ActiveRecord::Base
  belongs_to :follower
  belongs_to :account

  def follow_start

    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "6zEMTtOsh1FrUPaCRn34JEgA7"
      config.consumer_secret     = "PWsk0Sq7uCaNyurq8B3Jwchx9LS964vmuzhRTp6TtfzX9FFP7S"
      config.access_token        = "3193536466-wabyqg3GmuMhjELM5zlCttKJ1gIH6Hl0rWZOk2g"
      config.access_token_secret = "Df0GFxYnHWR3AGaGbOCNqsVvhrYhRBMGMXu5MP0Y0WFd3"
    end

    user = client.user(self.follower.uid.to_i)
    self.follower.update(:handle => user.handle)

    #follow
    client.follow(user, true)
    self.update(:followed => true)

    #next job
    jobs = self.account.auto_follows.where(:followed => nil)
    if jobs.count > 0
      jobs.first.delay(:run_at => Time.now + 1.minute).follow_start
    end

  end



end
