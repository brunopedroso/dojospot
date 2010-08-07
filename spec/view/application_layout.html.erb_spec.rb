require 'spec_helper'

describe 'application layout' do

	context 'when not logged in' do
			
			it 'should show a login link' do
				render('layouts/application')
				response.should have_tag('a[href=?]', '/login', 'Log in')
			end

			it 'should show a logout link' do
				render('layouts/application')
				response.should_not include_text('Log out')
			end
			
	end
	
	context 'when logged in' do

			before :each do
				@u = Factory.create :user
				session[:user_id] = @u.id
			end

			it 'should show the user name' do
				render('layouts/application')
				response.should have_text(/Welcome,(.*) foo/)
			end

			it 'should show logout link' do
				render('layouts/application')
				response.should have_tag('a[href=?]', '/logout', 'Log out')
			end

			it 'should not show a login link' do
				render('layouts/application')
				response.should_not include_text('Log in')
			end
			
			it 'should show a link to edit profile' do
				render('layouts/application')
				# puts response.body
				response.should have_tag('a[href=?]', edit_profile_path) do |link|
					link.should have_tag('img[src=?]', /\/images\/edit-pencil\.gif(.*)/)
				end
			end
			
			context 'with a user that has filled in his real name' do
				
				it 'should show the user real name' do
					@u.name = "some real name"
					@u.save
					render('layouts/application')
					response.should have_text(/Welcome,(.*) some real name/)
				end
				
			end
			

	end
end
