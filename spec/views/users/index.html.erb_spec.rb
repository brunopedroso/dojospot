require 'spec_helper'
require 'digest/md5'

describe 'users/index.html.erb' do

	before :each do
		@user1 = Factory.create(:user)
		@user2 = Factory.create(:user)
		assign :users, [@user1, @user2]
	end
	
	it 'should contain usernames' do
		render
		rendered.should contain(@user1.username)
		rendered.should contain(@user2.username)
	end

	it 'should contain user names when this field is filled' do
		@user1.name="foo bar"
		render
		rendered.should contain(@user1.name)
		rendered.should contain(@user2.username)
	end

	it 'should contain users gravatars' do
		render
		hash1 = Digest::MD5.hexdigest(@user1.email)
		hash2 = Digest::MD5.hexdigest(@user2.email)
		rendered.should have_selector('img', :src=> "http://www.gravatar.com/avatar/#{hash1}.png?s=")
		rendered.should have_selector('img', :src=> "http://www.gravatar.com/avatar/#{hash2}.png?s=")
	end

	it 'should contain personal pages link in name and gravatar' do
		@user1.name="foo bar"
		@user1.page_url="http://mypage.com"
		render
		rendered.should have_selector('a', :href=> @user1.page_url, :content=>@user1.name)
		rendered.should have_selector('a', :href=> @user1.page_url) do |a|
			hash1 = Digest::MD5.hexdigest(@user1.email)
			a.should have_selector('img', :src=> "http://www.gravatar.com/avatar/#{hash1}.png?s=")
		end
	end


end