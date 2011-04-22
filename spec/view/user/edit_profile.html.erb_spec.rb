require 'spec_helper'
require 'nokogiri'
require 'digest/md5'

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

	it 'should display validation errors' do

		error = mock()
		error.stub!(:full_messages).and_return('an error')
		error.stub!(:count).and_return(1)
		
		@user = mock_model(User)
		@user.stub!(:name).and_return('a name')
		@user.stub!(:email).and_return('an email')
		@user.stub!(:page_url).and_return('')
		@user.stub!(:errors).and_return(error)
		
		assigns[:user] = @user
		
		render 'users/edit'
		response.should include_text 'an error'
	end

	it "should pre fill the name field" do
		@user.name="brunous"
		render('/users/edit')
		doc = Nokogiri::HTML(response.body)
		input = doc.search('input[type="text"][name="user[name]"][value="brunous"]')
		input.length.should == 1
	end

	it "should show the gravatar for the provided email" do
		@user.email = "test"
		hash = Digest::MD5.hexdigest(@user.email)
		render 'users/edit'
		response.should have_tag('img[src=?]', /http\:\/\/www.gravatar.com\/avatar\/#{hash}\.png.*/)
	end
	
	it 'should have an input field for email' do
		render 'users/edit'
		response.should have_tag('input[type=?][name=?]', 
															'text', 'user[email]')
	end

	it 'should have an input field for personal page url' do
		render 'users/edit'
		response.should have_tag('input[type=?][name=?]', 
															'text', 'user[page_url]')
	end
	
	
end
