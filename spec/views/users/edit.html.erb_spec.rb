require 'spec_helper'
require 'nokogiri'
require 'digest/md5'

describe 'users/edit.html.erb' do

	before :each do
		@user = Factory.create(:user)
		assign :user, @user
	end
	
	it 'should have an input field for name' do
		render
		rendered.should have_selector('input', :type=>'text', :name=>'user[name]')
	end

	it 'should have a save button' do
		render
		rendered.should have_selector('input', :type=>'submit', :name=> 'save', :value=>'Save')
	end
	
	it 'should have a form that puts to /user/' do

		render
		
		rendered.should have_selector('form', :action=> user_path(@user)) do |f|
			f.should have_selector('input', :type=>'hidden', :name=>'_method', :value=>'put')
		end
	end
	

	it 'should display validation errors' do

		@user = User.new(:password=>"foofoo")
		@user.valid?
		
		assign :user, @user
		
		render
		rendered.should contain 'Username can\'t be blank '
	end

	it "should pre fill the name field" do
		@user.name="brunous"
		render
		doc = Nokogiri::HTML(rendered)
		input = doc.search('input[type="text"][name="user[name]"][value="brunous"]')
		input.length.should == 1
	end

	it "should show the gravatar for the provided email" do
		@user.email = "test"
		hash = Digest::MD5.hexdigest(@user.email)
		render
		rendered.should have_selector('img', :src => "http://www.gravatar.com/avatar/#{hash}.png?s=")
	end
	
	it 'should have an input field for email' do
		render
		rendered.should have_selector('input', :type=> 'text', :name=>'user[email]')
	end

	it 'should have an input field for personal page url' do
		render
		rendered.should have_selector('input', :type=>'text', :name=>'user[page_url]')
	end
	
	
end
