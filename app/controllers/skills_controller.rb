class SkillsController < ApplicationController

  def create
pry
    @vacancy = Vacancy.find(params["skill"]["vacancy_id"])
    added_skills = params["skill"]["name"].split(',')

    added_skills.each do |skill|

      existing_skill = Skill.find_by_name(skill)

      if existing_skill != nil
         add_vacancy_skill_association(existing_skill)  if @vacancy.skills.find_by_id(existing_skill.id).nil?    
      else
         create_new_skill(skill)
      end
    end
    respond_to do |format|
        format.js 
    end
  end

  def destroy
    @vacancy = Vacancy.find(params["vacancy_id"])
    if @vacancy != nil
       destroy_vacancy_skill_association 
       return
    end
    respond_to do |format|
      format.html { redirect_to skills_url, notice: 'Skill was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def create_new_skill(skill)
    @skill = Skill.new(name: skill)
    @skill.save
    @vacancy.skills << @skill
  end  

  def add_vacancy_skill_association(new_skill)
    @vacancy.skills << new_skill
  end  

  def destroy_vacancy_skill_association

    skill = Skill.find(params["id"])
    @vacancy.skills.delete(skill)

    respond_to do |format|
      format.js
    end
  end   
end
