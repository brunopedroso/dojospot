require 'spec_helper'

describe 'edit profile page' do

	before :each do
		@user = Factory.create(:user)
		assigns[:user] = @user
	end
	
	it 'should have an input field for name' do
		render 'users/edit'
		response.should have_tag('input[type=?][name=?][value=?]', 
															'text', 'name', '')
	end

	it 'should have a save button' do
		render 'users/edit'
		response.should have_tag('input[type=?][name=?][value=?]', 
															'submit', 'save', 'save')
	end
	
	it 'should have a form that puts to /user/' do

		render 'users/edit'
		
		response.should have_tag('form[action=?]', user_path(@user)) do |f|
			f.should have_tag('input[type=?][name=?][value=?]', 'hidden', '_method', 'put')
		end
	end
	
	it 'should display the flash[:notice]' do
		flash[:notice] = "any message"
		render 'users/edit'
		response.should include_text flash[:notice]
	end

	it "should pre fill the name field" do
		
	 	dojo_session = Factory.create(:dojo_session, :name=>'brunous')
		assigns[:dojo_session] = dojo_session 
		render('/users/edit')
		
		response.should have_tag('input[type="text"][name="name"][value="brunous"]')
		
	end


	
end
