# encoding: UTF-8
require 'spec_helper'

describe '/home/index.html.erb' do

	before :each do
		assign :dojo_sessions, []
		
		@user = Factory.create(:user)
	  
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
	
	context 'proposed sessions display list' do
	
		it 'should show no-sessions message without proposed sessions' do 
			render
			rendered.should have_selector('p', :content=>'No proposed sessions at the moment')
		end

		context 'link to propose session' do
			
			it 'should show a link to propose, if there are no sessions and Im an authorized and logged in user' do 
				assign :dojo_sessions, []
				#session[:user_id] = Factory.create(:user, :has_propose_priv => true).id
				@user.has_propose_priv=true
				@user.save
				render
				rendered.should have_selector('a', :href=>'/dojo_sessions/new', :content=>'Propose a new session')
			end

			it 'should not show the link to propose, if there are sessions' do 
				assign :dojo_sessions, [Factory.create(:dojo_session)]
				#session[:user_id] = Factory.create(:user, :has_propose_priv => true).id
				@user.has_propose_priv=true
				@user.save
				render
				rendered.should_not have_selector('a', :href=>'/dojo_sessions/new', :content=>'Propor uma nova sessão')
			end

			it 'should not show the link to propose, if im not logged in' do 
				assign :dojo_sessions, []
				render
				rendered.should_not have_selector('a', :href=>'/dojo_sessions/new', :content=>'Propor uma nova sessão')
			end

			it 'should not show the link to propose, if i have no privileges' do 
				assign :dojo_sessions, []
				#session[:user_id] = Factory.create(:user, :has_propose_priv => false).id
				@user.has_propose_priv=false
				@user.save
				render
				rendered.should_not have_selector('a', :href=>'/dojo_sessions/new', :content=>'Propor uma nova sessão')
			end
			
		end

		context 'details' do
	
			before :each do 
				@dojo_session = Factory.create(:dojo_session, :confirmed_users=>[Factory.create(:user)])
				assign :dojo_sessions, [@dojo_session]
				render
			end
	
			it 'should show the next proposed session date and title' do
				rendered.should contain( @dojo_session.title)
				rendered.should contain(I18n.l(@dojo_session.date, :format=>:pretty))
				
			end
			
			it 'should present date in brazilian format' do
				the_date = I18n.l @dojo_session[:date], :format=>:pretty
				rendered.should contain(the_date)
			end
				
			it 'should not show the no-sessions message' do
				rendered.should_not have_selector('p', :content=>'No proposed sessions at the moment')
			end
					
		end
	
		it 'should show the three proposed sessions' do
		  dojo_sessions = [Factory.create(:dojo_session), Factory.create(:dojo_session), Factory.create(:dojo_session)]
			assign :dojo_sessions, dojo_sessions
			render
			rendered.should have_selector('div', :id=>"next_sessions", :content=> dojo_sessions[0].title)
			rendered.should have_selector('div', :id=>"next_sessions", :content=> dojo_sessions[1].title)
			rendered.should have_selector('div', :id=>"next_sessions", :content=> dojo_sessions[2].title)
		end
	
		it 'should show a link to the sessions list' do
			assign :dojo_sessions, [Factory.create(:dojo_session)]
			render
			rendered.should have_selector('div', :id=>"next_sessions") do |div|
				div.should have_selector('a', :href=>dojo_sessions_path, :content=>'more details >>')
			end
		end
		
	end
	
	it 'should have a link to the sessions history' do
		render
		rendered.should have_selector('a', :href=>"/history", :content=>'Past sessions')
	end

	it 'should have a link to the all participants page' do
		render
		rendered.should have_selector('a', :href=>"/users", :content=>'Who we are?')
	end
	
end