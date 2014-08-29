# -*- encoding : utf-8 -*-
class Vacancy < ActiveRecord::Base


	has_and_belongs_to_many :skills

    validates_presence_of     :name, :validity_period, :salary, :contact_information
	validates_numericality_of :salary, greater_than: 0
	validates_numericality_of :validity_period, greater_than: 0, less_than: 13


	scope :filter_valid_vacancies,     -> { all.where("vacancies.id IN (?)", Vacancy.valid_vacancies) }
	scope :vacancy_links,              -> { joins("LEFT OUTER JOIN skills_vacancies sv ON vacancies.id = sv.vacancy_id") }
	scope :group_by_vacancies,         -> { select("vacancies.id, vacancies.name, vacancies.salary, COUNT(sv.skill_id), COUNT(ask.skill_id)").group("vacancies.id") }
    scope :having_by_skills,           -> { having("COUNT(sv.skill_id) <= COUNT(ask.skill_id)") }
    scope :having_by_skills_partially, -> { having("COUNT(sv.skill_id) > COUNT(ask.skill_id)") }
    scope :order_by_salary,            -> { order("vacancies.salary DESC") }


  
	def valid_to
        created_at.advance(:months => validity_period)
	end

	def self.valid_vacancies
		valid_vacancies_ids = []
		Vacancy.find_each do |v| 
			valid_vacancies_ids.push(v.id) if v.created_at <= Time.now and v.valid_to >= Time.now
		end
		valid_vacancies_ids
	end			
end