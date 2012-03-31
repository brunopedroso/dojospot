require 'spec_helper'

describe 'layouts/application.html.erb' do

	before :each do
		controller.singleton_class.class_eval do
      protected
        def logged_in?
          not User.first.nil?
        end
        def current_user
          User.first
        end
        helper_method :logged_in?
        helper_method :current_user
    end
	  
		
	end

	context 'when not logged in' do
			
			it 'should show a login link' do
				render
				rendered.should have_selector('a', :href=> '/login', :content=> 'Log in')
			end

			it 'should show a logout link' do
				render
				rendered.should_not contain('Log out')
			end
			
	end
	
	context 'when logged in' do

			before :each do
				@u = Factory.create :user
				#session[:user_id] = @u.id
			end

			it 'should show the user name' do
				render
				rendered.should have_content('Welcome, foo')
			end

			it 'should show logout link' do
				render
				rendered.should have_selector('a', :href => '/logout', :content => 'Log out')
			end

			it 'should not show a login link' do
				render
				rendered.should_not have_content('Log in')
			end
			
			it 'should show a link to edit profile' do
				render
				# puts response.body
				rendered.should have_selector('a', :href => edit_profile_path) do |link|
					link.should have_selector('img', :src => '/assets/edit-pencil.gif')
				end
			end
			
			context 'with a user that has filled in his real name' do
				
				it 'should show the user real name' do
					@u.name = "some real name"
					@u.save
					render
					render.should have_content('Welcome, some real name')
				end
				
			end
	end
	
	it 'should display the flash[:notice]' do
		flash[:notice] = "any message"
		render
		rendered.should contain flash[:notice]
	end
	
	
end
