class CreateAssociations < ActiveRecord::Migration
  def change
    create_table :applicants_skills, id: false do |t|
      t.belongs_to :applicant, index: true
      t.belongs_to :skill, index: true
    end
    create_table :skills_vacancies, id: false do |t|
      t.belongs_to :skill, index: true
      t.belongs_to :vacancy, index: true      
    end    
  end
end

