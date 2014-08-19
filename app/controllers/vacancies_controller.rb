class VacanciesController < ApplicationController

	before_action :set_vacancy, only: [:show, :edit, :update, :destroy]


  def index
    @vacancies = Vacancy.all.order(created_at: :desc)
  end

  def show
    @matched_applicants = Applicant.find_by_sql("SELECT a.id, a.name, a.desirable_salary, COUNT(ask.skill_id), vsc.cnt
                                                 FROM applicants_skills ask
                                                 JOIN applicants a
                                                   ON ask.applicant_id = a.id
                                                  AND a.status = 'job search'
                                                 LEFT JOIN skills_vacancies sv
                                                   ON ask.skill_id = sv.skill_id
                                                  AND sv.vacancy_id = #{@vacancy.id}
                                                 JOIN (SELECT COUNT(*) AS cnt, vacancy_id 
                                                            FROM skills_vacancies 
                                                            WHERE vacancy_id = #{@vacancy.id}
                                                            GROUP BY vacancy_id) AS vsc
                                                   ON vsc.vacancy_id = sv.vacancy_id            
                                                GROUP BY a.id, a.desirable_salary, vsc.cnt
                                               HAVING COUNT(ask.skill_id) >= vsc.cnt
                                               ORDER BY a.desirable_salary;")

    @part_matched_applicants = Applicant.find_by_sql("SELECT a.id, a.name, a.desirable_salary, COUNT(ask.skill_id), vsc.cnt
                                                 FROM applicants_skills ask
                                                 JOIN applicants a
                                                   ON ask.applicant_id = a.id
                                                  AND a.status = 'job search'
                                                 LEFT JOIN skills_vacancies sv
                                                   ON ask.skill_id = sv.skill_id
                                                  AND sv.vacancy_id = #{@vacancy.id}
                                                 JOIN (SELECT COUNT(*) AS cnt, vacancy_id 
                                                            FROM skills_vacancies 
                                                            WHERE vacancy_id = #{@vacancy.id}
                                                            GROUP BY vacancy_id) AS vsc
                                                   ON vsc.vacancy_id = sv.vacancy_id            
                                                GROUP BY a.id, a.desirable_salary, vsc.cnt
                                               HAVING COUNT(ask.skill_id) < vsc.cnt
                                               ORDER BY a.desirable_salary;;")   
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
        @model_object = @vacancy
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
