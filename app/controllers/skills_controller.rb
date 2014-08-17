class SkillsController < ApplicationController


  before_action :set_skill, only: [:destroy]

  def index
    @skills = Skill.all
  end
  
  def create

    @model_name = params["skill"]["model_name"]
    @vacancy = Vacancy.find(params["skill"]["vacancy_id"]) if @model_name == "vacancy"
    @applicant = Applicant.find(params["skill"]["applicant_id"]) if @model_name == "applicant"
    added_skills = params["skill"]["name"].split(',')

    added_skills.each do |skill|

      existing_skill = Skill.find_by_name(skill)

      if existing_skill != nil
         add_skill_association(existing_skill, @model_name) if association_not_exist?(existing_skill, @model_name)
      else
         create_new_skill(skill, @model_name)
      end
    end
    @model_object = @vacancy || @applicant
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
       destroy_skill_association(@model_name)
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

  def association_not_exist?(skill, model_name)

      if model_name == "applicant"
         @applicant.skills.find_by_id(skill.id).nil?
      else
         @vacancy.skills.find_by_id(skill.id).nil?
      end   
  end 

  def create_new_skill(skill, model_name)
    @skill = Skill.new(name: skill)
    @skill.save
    add_skill_association(@skill, model_name) if model_name != "skill"
  end  

  def add_skill_association(new_skill, model_name)
      if model_name == "applicant"
         @applicant.skills << new_skill
      else
         @vacancy.skills << new_skill
      end     
  end  

  def destroy_skill_association(model_name)

    skill = Skill.find(params["id"])
  
    if model_name == "vacancy"
       @vacancy.skills.delete(skill)
    else 
       @applicant.skills.delete(skill)
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
