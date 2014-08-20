require 'spec_helper'
require 'rails_helper'

describe SkillsController do

	let(:skill) { Skill.new(:name => "New skill")
		        }

	def valid_attributes 
		{ :name => "New skill" }
	end	    


	before :each do
	allow(Skill).to receive(:persisted?).and_return(true)
	allow(Skill).to receive(:order).with('name').and_return([skill])
	allow(Skill).to receive(:find).with(skill.id.to_s).and_return(skill)
	allow(skill).to receive(:save).and_return(true)
	@model_name = "vacancy"
	@vacancy = Vacancy.create(:id => 1,
		                   :name => "Ruby developer",
	                       :validity_period=> "12",
	                       :salary => "1200",
	                       :contact_information => "Kharkiv, 096 7325689")
	@skill = Skill.create(:id => 1,
		                   :name => "Ruby skill")	
	@vacancy.skills << @skill
	end

		describe "POST #create" do
		context "with valid attributes" do
			before :each do
				post :create, skill: valid_attributes
			end
			it "creates a new skill" do
				expect(Skill.exists?(assigns[:skill])).to be(true)
			end
			it "redirects to the new skill" do
				expect(response).to redirect_to Skill.last
			end
		end
		context "with invalid attributes" do
			before :each do
			post :create, skill: invalid_attributes
			end
			it "does not save the new skill" do
				expect(Skill.exists?(skill)).to be(false)
			end
			it "re-renders the new method" do
				expect(response).to render_template("new")
			end
			end
		end

		describe 'DELETE destroy' do
			before :each do
				allow(skill).to receive(:destroy).and_return(true)
				delete :destroy, id: skill
			end
			it "deletes the skill" do
				expect(Skill.exists?(skill)).to be(false)
			end
				it "redirects to skills#index" do
				expect(response).to redirect_to skills_url
			end
		end

end