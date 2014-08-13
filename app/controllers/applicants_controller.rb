class ApplicantsController < ApplicationController

	before_action :set_applicant, only: [:show, :edit, :update, :destroy]

  def index
    @applicants = Applicant.all
  end

  def show
  end

  def new
    @applicant = Applicant.new
  end

  def edit
  end

  def create
    @applicant = Applicant.new(applicant_params)
pry
    respond_to do |format|
      if @applicant.save
        format.html { redirect_to @applicant, notice: 'Applicant was successfully created.' }
        format.json { render :show, status: :created, location: @applicant }
      else
        format.html { render :new }
        format.json { render json: @applicant.errors, status: :unprocessable_entity }
      end
    end
  end

    def update
    respond_to do |format|
      if @applicant.update(applicant_params)
        format.html { redirect_to @applicant, notice: 'Applicant was successfully updated.' }
        format.json { render :show, status: :ok, location: @applicant }
      else
        format.html { render :edit }
        format.json { render json: @applicant.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @applicant.destroy
    respond_to do |format|
      format.html { redirect_to applicants_url, notice: 'Applicant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end  

  	private

  def set_applicant
      @applicant = Applicant.find(params[:id])
  end

  def applicant_params
      params.require(:applicant).permit(:name, :contact_information, :status, :desirable_salary)
  end
end
