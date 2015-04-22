class AccountController < ApplicationController
  def index

    #$client.update("Whoa! This works")
    #@tweets = $client.search("maxwell #ipl", :result_type => "recent" , :count => 3).take(3)

    @followers_ids = $client.follower_ids("AltCricket")


    @user = $client.user(@followers_ids.first)

    #current_user = $client.user("vignesh_p")
    #85294852

    $client.follow(@user, true)


  end
end


#
#class AccountController < ApplicationController
#  def index
#
#    #$client.update("Whoa! This works")
#    #@tweets = $client.search("maxwell #ipl", :result_type => "recent" , :count => 3).take(3)
#
#    @followers_ids = $client.follower_ids("AltCricket")
#
#    puts @followers_ids.first(10)
#    #@user = $client.user(@followers_ids.last)
#
#
#
#  end
#end
