class CelebritiesController < ApplicationController
  before_action :set_celebrity, only: [:show, :edit, :update, :destroy]

  # GET /celebrities
  # GET /celebrities.json
  def index
    @celebrities = Celebrity.all
  end

  # GET /celebrities/1
  # GET /celebrities/1.json
  def show
  end

  # GET /celebrities/new
  def new
    @celebrity = Celebrity.new
  end

  # GET /celebrities/1/edit
  def edit
  end

  # POST /celebrities
  # POST /celebrities.json
  def create
    @celebrity = Celebrity.new(celebrity_params)

    respond_to do |format|
      if @celebrity.save
        format.html { redirect_to @celebrity, notice: 'Celebrity was successfully created.' }
        format.json { render action: 'show', status: :created, location: @celebrity }
      else
        format.html { render action: 'new' }
        format.json { render json: @celebrity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /celebrities/1
  # PATCH/PUT /celebrities/1.json
  def update
    respond_to do |format|
      if @celebrity.update(celebrity_params)
        format.html { redirect_to @celebrity, notice: 'Celebrity was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @celebrity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /celebrities/1
  # DELETE /celebrities/1.json
  def destroy
    @celebrity.destroy
    respond_to do |format|
      format.html { redirect_to celebrities_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_celebrity
      @celebrity = Celebrity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def celebrity_params
      params.require(:celebrity).permit(:uid, :handle, :category, :account_id)
    end
end
