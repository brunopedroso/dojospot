require 'spec_helper'
require 'nokogiri'

describe 'edit profile page' do

	before :each do
		@user = Factory.create(:user)
		assigns[:user] = @user
	end
	
	it 'should have an input field for name' do
		render 'users/edit'
		response.should have_tag('input[type=?][name=?]', 
															'text', 'user[name]')
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
		@user.name="brunous"
		render('/users/edit')
		doc = Nokogiri::HTML(response.body)
		input = doc.search('input[type="text"][name="user[name]"][value="brunous"]')
		input.length.should == 1
	end


	
end
