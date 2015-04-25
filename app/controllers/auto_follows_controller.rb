class AutoFollowsController < ApplicationController
  before_action :set_auto_follow, only: [:show, :edit, :update, :destroy]

  # GET /auto_follows
  # GET /auto_follows.json
  def index
    @auto_follows = AutoFollow.all
  end

  # GET /auto_follows/1
  # GET /auto_follows/1.json
  def show
  end

  # GET /auto_follows/new
  def new
    @auto_follow = AutoFollow.new
  end

  # GET /auto_follows/1/edit
  def edit
  end

  # POST /auto_follows
  # POST /auto_follows.json
  def create
    @auto_follow = AutoFollow.new(auto_follow_params)

    respond_to do |format|
      if @auto_follow.save
        format.html { redirect_to @auto_follow, notice: 'Auto follow was successfully created.' }
        format.json { render action: 'show', status: :created, location: @auto_follow }
      else
        format.html { render action: 'new' }
        format.json { render json: @auto_follow.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /auto_follows/1
  # PATCH/PUT /auto_follows/1.json
  def update
    respond_to do |format|
      if @auto_follow.update(auto_follow_params)
        format.html { redirect_to @auto_follow, notice: 'Auto follow was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @auto_follow.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /auto_follows/1
  # DELETE /auto_follows/1.json
  def destroy
    @auto_follow.destroy
    respond_to do |format|
      format.html { redirect_to auto_follows_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_auto_follow
      @auto_follow = AutoFollow.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def auto_follow_params
      params.require(:auto_follow).permit(:account_id, :follower_id, :followed, :follow_back)
    end
end
