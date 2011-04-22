require 'spec_helper'
require 'digest/md5'

describe 'user index page' do

	before :each do
		@user1 = Factory.create(:user)
		@user2 = Factory.create(:user)
		assigns[:users] = [@user1, @user2]
	end
	
	it 'should contain usernames' do
		render 'users/index'
		response.should include_text(@user1.username)
		response.should include_text(@user2.username)
	end

	it 'should contain user names when this field is filled' do
		@user1.name="foo bar"
		render 'users/index'
		response.should include_text(@user1.name)
		response.should include_text(@user2.username)
	end

	it 'should contain users gravatars' do
		render 'users/index'
		hash1 = Digest::MD5.hexdigest(@user1.email)
		hash2 = Digest::MD5.hexdigest(@user2.email)
		response.should have_tag('img[src=?]', /http\:\/\/www.gravatar.com\/avatar\/#{hash1}\.png.*/)
		response.should have_tag('img[src=?]', /http\:\/\/www.gravatar.com\/avatar\/#{hash2}\.png.*/)
	end

	it 'should contain personal pages link in name and gravatar' do
		@user1.name="foo bar"
		@user1.page_url="http://mypage.com"
		render 'users/index'
		response.should have_tag('a[href=?]', @user1.page_url, :text=>@user1.name)
		response.should have_tag('a[href=?]', @user1.page_url) do |a|
			hash1 = Digest::MD5.hexdigest(@user1.email)
			a.should have_tag('img[src=?]', /http\:\/\/www.gravatar.com\/avatar\/#{hash1}\.png.*/)
		end
	end


end