# -*- encoding : utf-8 -*-
class Applicant < ActiveRecord::Base

	has_and_belongs_to_many   :skills

    validates_presence_of     :name, :contact_information, :status, :desirable_salary
	validate                  :word_counts_shold_be_3
	validates_numericality_of :desirable_salary, greater_than: 0
	validate                  :only_cyrillic_symbols
	validate                  :email_or_phonenumber_in_contacts

    #scope :matched_skills, ->  { joins(:skills) }
    #scope :matched_vacancies_with_skills, ->  { joins(:skills) }
    #(product_id) { where(product_id: product_id) }

  private

    def word_counts_shold_be_3
       errors[:name_of_applicant] << "Expected 3 words in this field" if name.split.size != 3
    end	

    def only_cyrillic_symbols
    	trimmed_name = name.gsub(' ', '')
    	mathed_name = /\p{Cyrillic}+/.match trimmed_name
        errors[:name_of_applicant] << "Expected only cyrillic symbols" if mathed_name.to_s != trimmed_name
    end	  

    def email_or_phonenumber_in_contacts
    	counter = 0
        divided_contact = contact_information.split()

        divided_contact.each do |part| 
        	
        	if /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/.match part
        		counter += 1
        	end	

        	part.gsub!(/[() +-,]+/, '')
        	matched_number = /[0-9]+/.match part
        	if matched_number.to_s.length > 9
        		counter += 1
        	end	        	
        end	
       errors[:contacts_information] << "In the contacts expected email or phone number (without spaces)" if counter == 0
    end	

end