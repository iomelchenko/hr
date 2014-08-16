# -*- encoding : utf-8 -*-
module SkillHelper

	def model_name
		if params[:controller] == "vacancies"
	   	     "vacancy"
	   	else
	   		 "applicant"
	   	end
	end	

	def model_object

		if params[:controller] == "vacancies"
	   	     @model = @vacancy
	   	else
	   		 @model = @applicant
	   	end
	end		
end