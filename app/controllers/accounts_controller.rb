class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy, :auto_follow]


  def callback
     account = Account.from_omniauth(env["omniauth.auth"])
     session[:user_id] = account.id
    redirect_to root_url , :notice => "Signed in"
  end

  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = Account.all

    if session[:user_id]
      user = Account.find(session[:user_id])
      client = Twitter::REST::Client.new do |config|
        config.consumer_key        = "VcIWuB5KjBuVe4a6Guuy6wOFF"
        config.consumer_secret     = "OhhaHaRG5y0e5md3Ci3wcnX6aQNDm4Qm8k604aDL0gAE7Cbj6a"
        config.access_token        = user.access_token
        config.access_token_secret = user.access_secret
      end
      #client.update("my app!")
    end


    #user = $aa_client.user("autoattend")
    #logger.debug user.id
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show


    begin
      if @account.name == "smooth_claire"
        @celeb = Celebrity.first
        follower_ids = $smooth_client.follower_ids(@celeb.handle)
      else
        @celeb = Celebrity.find(2)
        follower_ids = $aa_client.follower_ids(@celeb.handle)
      end

      count = 0
      follower_ids.each do |f|
        follower = Follower.new(:uid => f)
        follower.save
        AutoFollow.create(:account_id => @account.id , :follower_id => follower.id)
        @celeb.followers << follower
        count = count + 1
        logger.debug count.to_s + " records"

      end
        #follower_ids.to_a

    rescue Twitter::Error::TooManyRequests => error
      # NOTE: Your process could go to sleep for up to 15 minutes but if you
      # retry any sooner, it will almost certainly fail with the same exception.
      sleep error.rate_limit.reset_in + 1
      retry
    end

  end


  def auto_follow
    #initiate auto follow
    @account.auto_follows.where(:followed => nil).first.follow_start
  end


  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
    #initiate auto follow
    @account.auto_follows.where(:followed => nil , :inactive_user => nil).first.follow_start
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
    @account = Account.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def account_params
    params.require(:account).permit(:uid, :name, :pass)
  end
end
