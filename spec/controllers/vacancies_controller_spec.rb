require 'spec_helper'
require 'rails_helper'

describe VacanciesController do

	let(:vacancy) { Vacancy.new(:id => 1,
		:name => "Ruby developer",
	    :validity_period=> "12",
	    :salary => "1200",
	    :contact_information => "Kharkiv, 096 7325689")
		  }

	def valid_attributes 
		{ :name => "Ruby developer",
	      :validity_period=> "12",
	      :salary => "1200",
	      :contact_information => "Kharkiv, 096 7325689" }
	end	    

	def invalid_attributes 
		{ :name => "Ruby developer",
	      :validity_period=> "14",
	      :salary => "1200",
	      :contact_information => "Kharkiv, 096 7325689" }
	end		

	before :each do
	allow(Vacancy).to receive(:persisted?).and_return(true)
	allow(Vacancy).to receive(:order).with('name').and_return([vacancy])
	allow(Vacancy).to receive(:find).with(vacancy.id.to_s).and_return(vacancy)
	allow(vacancy).to receive(:save).and_return(true)
	end

		describe 'GET #index' do
			before :each do
			get :index
			end

			it "renders the :index view" do
				expect(response).to render_template "vacancies/index"
			end
		end
		describe 'GET #show' do
			before :each do
			allow(Vacancy).to receive(:find).with(vacancy.id.to_s).and_return(vacancy)
			get :show, id: vacancy
			end
			it "assigns the requested vacancy to @vacancy" do
				expect(assigns(:vacancy)).to eq vacancy
			end
			it "renders the :show template" do
				expect(response).to render_template :show
			end
		end

		describe 'GET #new' do
			before :each do
			get :new
			end
			it "assigns a new Vacancy to @vacancy" do
				expect(assigns(:vacancy)).to be_a_new(Vacancy)
			end
			it "renders the :new template" do
				expect(response).to render_template :new
			end
		end
		describe 'GET #edit' do
			it "assigns the requested vacancy to @vacancy" do
				get :edit, id: vacancy
				expect(assigns(:vacancy)).to eq vacancy
			end
			it "renders the :edit template" do
				get :edit, id: vacancy
				expect(response).to render_template :edit
			end
		end

		describe "POST #create" do
		context "with valid attributes" do
			before :each do
				post :create, vacancy: valid_attributes
			end
			it "creates a new vacancy" do
				expect(Vacancy.exists?(assigns[:vacancy])).to be(true)
			end
			it "redirects to the new vacancy" do
				expect(response).to redirect_to Vacancy.last
			end
		end
		context "with invalid attributes" do
			before :each do
			post :create, vacancy: invalid_attributes
			end
			it "does not save the new vacancy" do
				expect(Vacancy.exists?(vacancy)).to be(false)
			end
			it "re-renders the new method" do
				expect(response).to render_template("new")
			end
			end
		end

		describe 'PATCH #update' do
		context "valid attributes" do
			it "located the requested @vacancy" do
				allow(vacancy).to receive(:update).with(valid_attributes.stringify_keys) { true }
				patch :update, id: vacancy, vacancy: valid_attributes
				expect(assigns(:vacancy)).to eq(vacancy)
			end
				it "redirects to the updated vacancy" do
				patch :update, id: vacancy, vacancy: valid_attributes
				expect(response).to redirect_to vacancy
			end
		end
		context "invalid attributes" do
			before :each do
			allow(vacancy).to receive(:update).with(invalid_attributes.stringify_keys) { false }
			patch :update, id: vacancy, vacancy: invalid_attributes
			end
			it "locates the requested @vacancy" do
				expect(assigns(:vacancy)).to eq vacancy
			end
			it "does not change @vacancy's attributes" do
				expect(assigns[:vacancy].attributes).to eq vacancy.attributes
			end
			it "re-renders the edit method" do
				expect(response).to render_template :edit
			end
			end
		end

		describe 'DELETE destroy' do
			before :each do
				allow(vacancy).to receive(:destroy).and_return(true)
				delete :destroy, id: vacancy
			end
			it "deletes the vacancy" do
				expect(Vacancy.exists?(vacancy)).to be(false)
			end
				it "redirects to vacancies#index" do
				expect(response).to redirect_to vacancies_url
			end
		end

end