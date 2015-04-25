require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Twitter
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    #smooth_claire
    $claire_client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "6zEMTtOsh1FrUPaCRn34JEgA7"
      config.consumer_secret     = "PWsk0Sq7uCaNyurq8B3Jwchx9LS964vmuzhRTp6TtfzX9FFP7S"
      config.access_token        = "3193536466-wabyqg3GmuMhjELM5zlCttKJ1gIH6Hl0rWZOk2g"
      config.access_token_secret = "Df0GFxYnHWR3AGaGbOCNqsVvhrYhRBMGMXu5MP0Y0WFd3"
    end

    #vignesh_p
    #$client = Twitter::REST::Client.new do |config|
    #  config.consumer_key        = "GRLlE3JqMPJQP0xerXM6ucmKF"
    #  config.consumer_secret     = "twzSlJAd2dqh7QyVMHIK4q0NvbD8xyWmZgVKLq7LSmJc6ouuHQ"
    #  config.access_token        = "85294852-MC6yZcqLnqlExKz4qhLZL7VYL8Ez33Jn5TU9S8yPc"
    #  config.access_token_secret = "gOjIYHjK5dWFsPfF6RElYOcpzPBlZLAjXJ5hKHwj41kCm"
    #end

  #  auto attend
    $aa_client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "VcIWuB5KjBuVe4a6Guuy6wOFF"
      config.consumer_secret     = "OhhaHaRG5y0e5md3Ci3wcnX6aQNDm4Qm8k604aDL0gAE7Cbj6a"
      config.access_token        = "2939896867-Cj5trbDzoa4BKOCsS5nP2zxijOeseBKfYGC2XOV"
      config.access_token_secret = "56I5HhoNiClJASBQPIstnxbRxTM1VSILopduEHb8FG3Ti"
    end

  end

end
