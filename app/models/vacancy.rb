# -*- encoding : utf-8 -*-
class Vacancy < ActiveRecord::Base


	has_and_belongs_to_many :skills

    validates_presence_of     :name, :validity_period, :salary, :contact_information
	validates_numericality_of :salary
	validates_numericality_of :validity_period, less_than: 13

end