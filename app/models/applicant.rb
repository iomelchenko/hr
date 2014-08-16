# -*- encoding : utf-8 -*-
class Applicant < ActiveRecord::Base

	has_and_belongs_to_many :skills

	validate :word_counts_shold_be_3
	validates_numericality_of :desirable_salary
	#validates_format_of :name, :with => /\A[а-я А-Я]\Z/i
	validates_format_of :name, :with => /[а-я А-Я]/i, :message => "Invalid! Expected only cyrillic symbols."

  private

    def word_counts_shold_be_3
       errors[:name_of_applicant] << "Expected 3 words in this field" if name.split.size != 3
    end	

end