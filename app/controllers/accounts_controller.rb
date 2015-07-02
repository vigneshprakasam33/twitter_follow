class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy, :unfollow]


  def callback
    logger.debug "IN callback==========>"
    account = Account.from_omniauth(env["omniauth.auth"])
    session[:user_id] = account.id
    redirect_to "/celebrities", :notice => "Signed in"
  end


  def signout
    session[:user_id] = nil
    redirect_to "/celebrities", :notice => "Signed out successfully"
  end

  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = Account.all
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show

    client = get_client(@account)
    #scrape from latest celeb
    @celeb = @account.celebrities.last

    count = 0
    follower_ids = client.follower_ids(@celeb.handle)
    #all_followers = Follower.all.pluck(:uid)

    begin

      follower_ids.to_a

    rescue Twitter::Error::TooManyRequests => error

      logger.info "RATE EXCEEDED================>"
      # NOTE: Your process could go to sleep for up to 15 minutes but if you
      # retry any sooner, it will almost certainly fail with the same exception.
      sleep error.rate_limit.reset_in + 1
      retry
    rescue => error
      logger.info "error================>" + error.message
    end

    follower_ids.each do |f|
      #make sure unique followers
      #next if all_followers.include? f

      follower = Follower.new(:uid => f)
      follower.save
      AutoFollow.create(:follower_id => follower.id)
      @celeb.followers << follower
      count = count + 1
      logger.info count.to_s + " records"
    end


    logger.debug "finished==========>"

  end


  def unfollow
    #initiate un follow
    a = @account.auto_follows.where(:followed => true, :inactive_user => nil).first
    a.unfollow(@account)
    render "accounts/auto_follow"
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
    #initiate auto follow
    b = AutoFollow.where(:followed => nil, :inactive_user => nil).first
    b.update(:followed => true)
    b.follow_start(@account)
    render "accounts/auto_follow"
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(account_params)

    respond_to do |format|
      if @account.save
        format.html { redirect_to @account, notice: 'Account was successfully created.' }
        format.json { render action: 'show', status: :created, location: @account }
      else
        format.html { render action: 'new' }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_account
    if params[:id]
      @account = Account.find(params[:id])
    elsif params[:account_id]
      @account = Account.find(params[:account_id])
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def account_params
    params.require(:account).permit(:uid, :name, :pass, :account_id)
  end

  def get_client(user)
    #user = Account.find(session[:user_id])

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
      if proxy
      config.proxy = proxy
      end
    end

    client
  end
end
