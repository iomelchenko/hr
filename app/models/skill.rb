# -*- encoding : utf-8 -*-
class Skill < ActiveRecord::Base

	has_and_belongs_to_many :applicants
	has_and_belongs_to_many :vacancies		

	validates :name, presence: true, uniqueness: { case_sensitive: false }

	private

		def self.create_new_or_add_existed_skill(added_skills, model_object)

		    added_skills.each do |skill|

		      existing_skill = Skill.find_by_name_downcase(skill)
		      if existing_skill != nil
		         Skill.add_skill_association(existing_skill, model_object) if Skill.association_not_exist?(existing_skill, model_object)
		      else
		         Skill.create_new_skill(skill, model_object)
		      end
		    end	
		end

	    def self.find_by_name_downcase(name)
	      	Skill.all.each do |skill|
	      		return skill if skill.name.downcase == name.downcase
	      	end
	      	nil
	    end	

		def self.association_not_exist?(skill, model_object)
	         model_object.skills.find_by_id(skill.id).nil?
	    end
	         
	  	def self.create_new_skill(skill, model_object)
	    	@skill = Skill.new(name: skill)
	    	@skill.save
	    	self.add_skill_association(@skill, model_object)
	  	end  

	 	def self.add_skill_association(new_skill, model_object)
	       	  	model_object.skills << new_skill
	  	end 



		def self.destroy_skill_association(model_object, skill)
		    model_object.skills.delete(skill)
		end	  	 	        

end