class ApplicantsController < ApplicationController

	before_action :set_applicant, only: [:show, :edit, :update, :destroy]

  def index
    @applicants = Applicant.all.order(desirable_salary: :desc)
  end

  def show
    @matched_vacancies = Vacancy.find_by_sql("SELECT v.id, v.name, v.salary, COUNT(sv.skill_id), COUNT(ask.skill_id)
                                              FROM vacancies v 
                                              LEFT JOIN skills_vacancies sv
                                              ON v.id = sv.vacancy_id
                                              LEFT JOIN applicants_skills ask
                                              ON ask.skill_id = sv.skill_id
                                              AND ask.applicant_id = #{@applicant.id}
                                              WHERE now() BETWEEN v.created_at AND (v.created_at + CAST(v.validity_period || ' months' AS INTERVAL))
                                              GROUP BY v.id
                                              HAVING COUNT(sv.skill_id) <= COUNT(ask.skill_id)
                                              ORDER BY v.salary DESC;")

    @part_matched_vacancies = Vacancy.find_by_sql("SELECT v.id, v.name, v.salary, COUNT(sv.skill_id), COUNT(ask.skill_id)
                                              FROM vacancies v 
                                              LEFT JOIN skills_vacancies sv
                                              ON v.id = sv.vacancy_id
                                              LEFT JOIN applicants_skills ask
                                              ON ask.skill_id = sv.skill_id
                                              AND ask.applicant_id = #{@applicant.id}
                                              WHERE now() BETWEEN v.created_at AND (v.created_at + CAST(v.validity_period || ' months' AS INTERVAL))
                                              GROUP BY v.id
                                              HAVING COUNT(sv.skill_id) > COUNT(ask.skill_id)
                                              ORDER BY v.salary DESC;")     
  end

  def new
    @applicant = Applicant.new
  end

  def edit
    @model_object = @applicant
    @model_name = 'applicant'
  end

  def create
    @applicant = Applicant.new(applicant_params)
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
        @model_object = @applicant
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
