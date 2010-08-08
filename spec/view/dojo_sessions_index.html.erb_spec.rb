require 'spec_helper'

describe 'dojo sessions index' do
	
	context 'proposed sessions display list' do
		
		
		it 'should show no-sessions message without proposed sessions' do 
			assigns[:dojo_sessions] = []
			render('dojo_sessions/index')
			response.should have_tag('p', 'No proposed sessions at this moment')
		end

		context 'details' do

			before :each do 
				@dojo_session = Factory.create(:dojo_session, :confirmed_users=>[Factory.create(:user)])
				assigns[:dojo_sessions] = [@dojo_session]
			end

			it 'should render partail' do
				# view.should_receive(:render).with(:partial=>"dojo_session")
				# @controller.template.should_receive(:render)
				render('dojo_sessions/index')
				#TODO could not test this... :-/
			end

		end

		#TODO: mock the partial
		#TODO this next step ends asserting that the partial is being rendered, but not in the best way...
		
		it 'should show the three proposed sessions' do
			assigns[:dojo_sessions] = [Factory.create(:dojo_session), Factory.create(:dojo_session), Factory.create(:dojo_session)]
			render('dojo_sessions/index')
			dojo_sessions = assigns[:dojo_sessions]
			response.should have_tag('div[id=?]', "dojo_session_#{dojo_sessions[0].id}", :text=>/.*#{dojo_sessions[0].title}*/)
			response.should have_tag('div[id=?]', "dojo_session_#{dojo_sessions[1].id}", :text=>/.*#{dojo_sessions[1].title}*/)
			response.should have_tag('div[id=?]', "dojo_session_#{dojo_sessions[2].id}", :text=>/.*#{dojo_sessions[2].title}*/)
		end
		
	end

	context 'proposition' do
	
		before :each do 
			assigns[:dojo_sessions] = []
		end
	
		it 'should not show link to propose session when not logged in' do
			render('dojo_sessions/index')
			response.should_not have_tag('a[href=?]','/dojo_sessions/new')
		end

		it 'should not show link to propose session if i dont have such privilege' do
			session[:user_id] = Factory.create(:user, :has_propose_priv => false).id
			render('dojo_sessions/index')
			response.should_not have_tag('a[href=?]','/dojo_sessions/new')
		end

		it 'should show link to propose session when logged in' do
			session[:user_id] = Factory.create(:user, :has_propose_priv => true).id
			render('dojo_sessions/index')
			response.should have_tag('a[href=?]','/dojo_sessions/new','Propose a new session')
		end

	end


end