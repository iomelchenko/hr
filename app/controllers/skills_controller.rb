class SkillsController < ApplicationController


  before_action :set_skill, only: [:destroy]

  def index
    @skills = Skill.all
  end

  def refresh
    @skills = Skill.all

    respond_to do |format|
      format.json { render json: @skills }       
    end    
  end    
  
  def create

    @model_name = params["skill"]["model_name"]
    @vacancy = Vacancy.find(params["skill"]["vacancy_id"]) if @model_name == "vacancy"
    @applicant = Applicant.find(params["skill"]["applicant_id"]) if @model_name == "applicant"
    @model_object = @vacancy || @applicant
    added_skill = params["skill"]["name"]

    Skill.create_new_or_add_existed_skill(added_skill, @model_object)
   
    respond_to do |format|
        format.js 
    end
  end

  def destroy

    @model_name = params[:model_name]
    @vacancy = Vacancy.find(params["attribute_id"]) if @model_name == "vacancy"
    @applicant = Applicant.find(params["attribute_id"]) if @model_name == "applicant"
    @model_object = @vacancy || @applicant
    if @vacancy != nil or @applicant != nil
       Skill.destroy_skill_association(@model_object, @skill)
    else
       @skill.destroy
    end

    respond_to do |format|
      format.html { redirect_to skills_url, notice: 'Skill was successfully destroyed.' }
      format.js
      format.json { head :no_content }
    end
  end

  private

  def set_skill
      @skill = Skill.find(params[:id])
  end

  def skill_params
      params.require(:skill).permit(:name)
  end


end
