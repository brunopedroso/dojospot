require 'spec_helper'

describe 'application layout' do

	context 'not logged in' do
			
			it 'should show a login link' do
				render('layouts/application')
				response.should have_tag('a[href=?]', '/sessions/new', 'Log in')
			end

			it 'should show a logout link' do
				render('layouts/application')
				response.should_not include_text('Log out')
			end
			
	end
	
	context 'logged in' do

			before :each do
				u = Factory.create :user
				session[:user_id] = u.id
			end

			it 'should show the user name' do
				render('layouts/application')
				response.should include_text('Bem vindo, foo')
			end

			it 'should show logout link' do
				render('layouts/application')
				response.should have_tag('a[href=?]', '/logout', 'Log out')
			end


			it 'should not show a login link' do
				render('layouts/application')
				response.should_not include_text('Log in')
			end

	end
end
