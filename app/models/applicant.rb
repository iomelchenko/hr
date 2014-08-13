# -*- encoding : utf-8 -*-
class Applicant < ActiveRecord::Base

	has_and_belongs_to_many :skills

end