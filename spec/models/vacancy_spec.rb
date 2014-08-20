require 'spec_helper'
require 'rails_helper'

describe Vacancy do

  	before(:each) do
    	@vacancy = Vacancy.new
  	end

	it { should validate_presence_of :name}
	it { should validate_presence_of :validity_period }
	it { should validate_presence_of :salary }
	it { should validate_presence_of :contact_information }
	
end