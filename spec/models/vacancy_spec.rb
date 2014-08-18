require 'spec_helper'
require 'rails_helper'

describe Vacancy do
	#it "has a valid factory" do
	#	expect(build(:vacancy)).to be_valid
	#end
	it { should validate_presence_of :name}
	it { should validate_presence_of :validity_period }
	it { should validate_presence_of :salary }
	it { should validate_presence_of :contact_information }
	it { should validate_uniqueness_of(:name) }
	it "name shold has three worlds" do
		pending "name three worlds"
		expect(create(:vacancy).phones.count).to eq 3
	end
	it "name should has only cyrillic simbols" do
		pending "name should has only cyrillic simbols"
	end	
	describe "filter last name by letter" do
		let(:smith) { create(:vacancy,
			lastname: 'Smith', email: 'jsmith@example.com') }
		let(:jones) { create(:vacancy,
			lastname: 'Jones', email: 'tjones@example.com') }
		let(:johnson) { create(:vacancy,
			lastname: 'Johnson', email: 'jjohnson@example.com') }
		context "matching letters" do
			it "returns a sorted array of results that match" do
				expect(Vacancy.by_letter("J")).to eq [johnson, jones]
			end
		end
		context "non-matching letters" do
			it "returns a sorted array of results that match" do
				expect(Vacancy.by_letter("J")).to_not include smith
			end
		end
	end
end