class SkillltsController < ApplicationController
  before_action :set_skilllt, only: [:show, :edit, :update, :destroy]

  # GET /skilllts
  # GET /skilllts.json
  def index
    @skilllts = Skilllt.all
  end

  # GET /skilllts/1
  # GET /skilllts/1.json
  def show
  end

  # GET /skilllts/new
  def new
    @skilllt = Skilllt.new
  end

  # GET /skilllts/1/edit
  def edit
  end

  # POST /skilllts
  # POST /skilllts.json
  def create
    @skilllt = Skilllt.new(skilllt_params)

    respond_to do |format|
      if @skilllt.save
        format.html { redirect_to @skilllt, notice: 'Skilllt was successfully created.' }
        format.json { render :show, status: :created, location: @skilllt }
      else
        format.html { render :new }
        format.json { render json: @skilllt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /skilllts/1
  # PATCH/PUT /skilllts/1.json
  def update
    respond_to do |format|
      if @skilllt.update(skilllt_params)
        format.html { redirect_to @skilllt, notice: 'Skilllt was successfully updated.' }
        format.json { render :show, status: :ok, location: @skilllt }
      else
        format.html { render :edit }
        format.json { render json: @skilllt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /skilllts/1
  # DELETE /skilllts/1.json
  def destroy
    @skilllt.destroy
    respond_to do |format|
      format.html { redirect_to skilllts_url, notice: 'Skilllt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_skilllt
      @skilllt = Skilllt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def skilllt_params
      params.require(:skilllt).permit(:name, :title, :content)
    end
end
