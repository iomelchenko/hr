require 'spec_helper'
require 'rails_helper'

describe Applicant do
	#it "has a valid factory" do
	#	expect(build(:applicant)).to be_valid
	#end
  	before(:each) do
    	@applicant = Applicant.new(name: 'превое второе третье')
  	end

describe 'Applicants ' do	
	it "name should has three worlds" do
  		@applicant.name = 'Первое Второе'
  		@applicant.contact_information = '0973205674'
  		@applicant.status = 'job_search'
  		@applicant.desirable_salary = 1200
  		@applicant.save
  		@applicant.should_not be_valid
  		expect(@applicant.errors.messages[:name_of_applicant]).to eq ["Expected 3 words in this field"]

	end
	it "name should containe only cyrillic symbols" do
  		@applicant.name = 'Первое Two Третье'
  		@applicant.contact_information = '0973205674'
  		@applicant.status = 'job_search'
  		@applicant.desirable_salary = 1200
  		@applicant.save
  		@applicant.should_not be_valid
  		expect(@applicant.errors.messages[:name_of_applicant]).to eq ["Expected only cyrillic symbols"]
	end	
end	

end