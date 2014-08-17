class VacanciesController < ApplicationController

	before_action :set_vacancy, only: [:show, :edit, :update, :destroy]


  def index
    @vacancies = Vacancy.all
  end

  def show
  end

  def new
    @vacancy = Vacancy.new
  end

  def edit
    @model_object = @vacancy
    @model_name = 'vacancy'
  end

  def create
    @vacancy = Vacancy.new(vacancy_params)

    respond_to do |format|
      if @vacancy.save
        format.html { redirect_to @vacancy, notice: 'Vacancy was successfully created.' }
        format.json { render :show, status: :created, location: @vacancy }
      else
        format.html { render :new }
        format.json { render json: @vacancy.errors, status: :unprocessable_entity }
      end
    end
  end

    def update
    respond_to do |format|
      if @vacancy.update(vacancy_params)
        format.html { redirect_to @vacancy, notice: 'Vacancy was successfully updated.' }
        format.json { render :show, status: :ok, location: @vacancy }
      else
        format.html { render :edit }
        format.json { render json: @vacancy.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @vacancy.destroy
    respond_to do |format|
      format.html { redirect_to vacancies_url, notice: 'Vacancy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end  

  	private

  def set_vacancy
      @vacancy = Vacancy.find(params[:id])
  end

  def vacancy_params
      params.require(:vacancy).permit(:name, :validity_period, :salary, :contact_information)
  end
end
