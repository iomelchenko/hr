require 'spec_helper'
require 'rails_helper'

describe ApplicantsController do

	let(:applicant) { Applicant.new(:id => 1,
		    :name => "Иванов Иван Иванович",
		    :contact_information => "Kharkiv, 096 7325689",
		    :status => 'job search',
		    :desirable_salary => "1200")
		  }

	def valid_attributes 
		{ :name => "Иванов Иван Иванович",
		    :contact_information => "Kharkiv, 096 7325689",
		    :status => 'job search',
		    :desirable_salary => "1200" }
	end	    

	def invalid_attributes 
		{ :name => "Иванов Ивjjан Иванович",
		    :contact_information => "Kharkiv",
		    :status => 'job search',
		    :desirable_salary => "1200" }
	end		

	before :each do
	allow(Applicant).to receive(:persisted?).and_return(true)
	allow(Applicant).to receive(:order).with('name').and_return([applicant])
	allow(Applicant).to receive(:find).with(applicant.id.to_s).and_return(applicant)
	allow(applicant).to receive(:save).and_return(true)
	end

		describe 'GET #index' do
			before :each do
			get :index
			end

			it "renders the :index view" do
				expect(response).to render_template "applicants/index"
			end
		end
		describe 'GET #show' do
			before :each do
			allow(Applicant).to receive(:find).with(applicant.id.to_s).and_return(applicant)
			get :show, id: applicant
			end
			it "assigns the requested applicant to @applicant" do
				expect(assigns(:applicant)).to eq applicant
			end
			it "renders the :show template" do
				expect(response).to render_template :show
			end
		end

		describe 'GET #new' do
			before :each do
			get :new
			end
			it "assigns a new Applicant to @applicant" do
				expect(assigns(:applicant)).to be_a_new(Applicant)
			end
			it "renders the :new template" do
				expect(response).to render_template :new
			end
		end
		describe 'GET #edit' do
			it "assigns the requested applicant to @applicant" do
				get :edit, id: applicant
				expect(assigns(:applicant)).to eq applicant
			end
			it "renders the :edit template" do
				get :edit, id: applicant
				expect(response).to render_template :edit
			end
		end

		describe "POST #create" do
		context "with valid attributes" do
			before :each do
				post :create, applicant: valid_attributes
			end
			it "creates a new applicant" do
				expect(Applicant.exists?(assigns[:applicant])).to be(true)
			end
			it "redirects to the new applicant" do
				expect(response).to redirect_to Applicant.last
			end
		end
		context "with invalid attributes" do
			before :each do
			post :create, applicant: invalid_attributes
			end
			it "does not save the new applicant" do
				expect(Applicant.exists?(applicant)).to be(false)
			end
			it "re-renders the new method" do
				expect(response).to render_template("new")
			end
			end
		end

		describe 'PATCH #update' do
		context "valid attributes" do
			it "located the requested @applicant" do
				allow(applicant).to receive(:update).with(valid_attributes.stringify_keys) { true }
				patch :update, id: applicant, applicant: valid_attributes
				expect(assigns(:applicant)).to eq(applicant)
			end
				it "redirects to the updated applicant" do
				patch :update, id: applicant, applicant: valid_attributes
				expect(response).to redirect_to applicant
			end
		end
		context "invalid attributes" do
			before :each do
			allow(applicant).to receive(:update).with(invalid_attributes.stringify_keys) { false }
			patch :update, id: applicant, applicant: invalid_attributes
			end
			it "locates the requested @applicant" do
				expect(assigns(:applicant)).to eq applicant
			end
			it "does not change @applicant's attributes" do
				expect(assigns[:applicant].attributes).to eq applicant.attributes
			end
			it "re-renders the edit method" do
				expect(response).to render_template :edit
			end
			end
		end

		describe 'DELETE destroy' do
			before :each do
				allow(applicant).to receive(:destroy).and_return(true)
				delete :destroy, id: applicant
			end
			it "deletes the applicant" do
				expect(Applicant.exists?(applicant)).to be(false)
			end
				it "redirects to applicants#index" do
				expect(response).to redirect_to applicants_url
			end
		end

end