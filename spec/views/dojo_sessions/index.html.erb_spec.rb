require 'spec_helper'

describe 'dojo_sessions/index.html.erb' do
	
	before :each do 
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
			assign :dojo_sessions, []
			render
			rendered.should have_selector('p', :content=>'No proposed sessions at this moment')
		end

		context 'details' do

			before :each do 
				@dojo_session = Factory.create(:dojo_session, :confirmed_users=>[Factory.create(:user)])
				assign :dojo_sessions, [@dojo_session]
			end

			it 'should render partail' do
				# view.should_receive(:render).with(:partial=>"dojo_session")
				# @controller.template.should_receive(:render)
				render
				#TODO could not test this... :-/
			end

		end

		#TODO: mock the partial
		#TODO this next step ends asserting that the partial is being rendered, but not in the best way...
		
		it 'should show the three proposed sessions' do
		  dojo_sessions = [Factory.create(:dojo_session), Factory.create(:dojo_session), Factory.create(:dojo_session)]
			assign :dojo_sessions, dojo_sessions
			render
			
			rendered.should have_selector('div', :id=>"dojo_session_#{dojo_sessions[0].id}", :content=> dojo_sessions[0].title)
			rendered.should have_selector('div', :id=>"dojo_session_#{dojo_sessions[1].id}", :content=> dojo_sessions[1].title)
			rendered.should have_selector('div', :id=>"dojo_session_#{dojo_sessions[2].id}", :content=> dojo_sessions[2].title)
		end
		
	end

	context 'proposition' do
	
		before :each do 
			assign :dojo_sessions, []
		end
	
		it 'should not show link to propose session when not logged in' do
			render
			rendered.should_not have_selector('a', :href=>'/dojo_sessions/new')
		end

		it 'should not show link to propose session if i dont have such privilege' do
			#session[:user_id] = Factory.create(:user, :has_propose_priv => false).id
			@user.has_propose_priv=false
			@user.save
			render
			rendered.should_not have_selector('a', :href=>'/dojo_sessions/new')
		end

		it 'should show link to propose session when logged in' do
			#session[:user_id] = Factory.create(:user, :has_propose_priv => true).id
			@user.has_propose_priv=true
			@user.save
			render
			rendered.should have_selector('a', :href=>'/dojo_sessions/new', :content=>'Propose a new session')
		end

	end


end