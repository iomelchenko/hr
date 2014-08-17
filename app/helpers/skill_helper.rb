# -*- encoding : utf-8 -*-
module SkillHelper

	def model_name1
		if    params[:controller] == "vacancies"
	   	         "vacancy"
	   	elsif params[:controller] == "applicants"
	   		     "applicant"
	   	else
                 "skill"
	   	end
	end	

end