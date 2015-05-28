require 'rake'

  #retweet last tweet of an account
  task :retweet => :environment do
  #puts "Args were: #{args[:account]}"

  #find last tweet of this account and retweet
  retweet_account = Account.find_by_name("autoattend")

  #pick accounts to retweet
  accounts = [
      #"smooth_claire",
      #    "autoattend",
      "dannys_pics",
      "candy_cameras",
      "jennys_lens",
      #"giselle_lens",
      "james_lens",
      "marcus_lens",
      #"peters_lens",
      "barry_lens",
      "shamira_lens",
      #"cuddly_cuties",
      "jacobs_pix",
      "PicsFactory",
      #"GlobeTrotterPic",
      "PicsRaja",
      "BlissPix",
      "stunning_lens",
      "jason_lens",
      "PhotosMojos",
      #"photo_sharpness",
      "mesmerising_pic",
      "awesomatic_pic",
      "fantabulous_pic",
      "salim_lens",
      #"alluring_pix",
      "ThatsAwesomePic",
      "PicBoxOfEarth",
      "Photoking001",
      "Photowizard200",
      #"Camerapro101",
      "Camerawizard20",
      "Photopro500",
      "Lenspro200",
      #"Lensking150",
      "Creativecam001",
      "Bestlens300",
      "photoshome522",
      #"sharplens330",
      "Photoguru221",
      "photobase112",
      "Sharpcamera322",
      #"photozone110",
      "Lenscenter220",
      "photohouse222",
      "camerabase111",
      #"Lensboss202",
      "lensguru220",
      "phototeam200"]

  accounts.each do |name|

    user = Account.find_by_name name

    if !user.proxy.blank?
    proxy = {
        host: user.proxy,
        port: 3128
    }
    end


    client = Twitter::REST::Client.new do |config|
      config.consumer_key = "GRLlE3JqMPJQP0xerXM6ucmKF"
      config.consumer_secret = "twzSlJAd2dqh7QyVMHIK4q0NvbD8xyWmZgVKLq7LSmJc6ouuHQ"
      config.access_token = user.access_token
      config.access_token_secret = user.access_secret
      if proxy
        config.proxy = proxy
      end
    end

    #twitter account whose last tweet to be retweeted
    u ||= client.user(retweet_account.name)

    #retweeting
    client.retweet u.status.id

    puts "retweeted from #{name}"
  end

end