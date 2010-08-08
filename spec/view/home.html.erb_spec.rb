require 'spec_helper'

describe 'home page' do

	before :each do
		assigns[:dojo_sessions] = []
	end
	
	context 'proposed sessions display list' do
	
		it 'should show no-sessions message without proposed sessions' do 
			render('/home/index')
			response.should have_tag('p', 'Nenhuma sessão proposta no momento.')
		end

		context 'link to propose session' do
			
			it 'should show a link to propose, if there are no sessions and Im an authorized and logged in user' do 
				assigns[:dojo_sessions] = []
				session[:user_id] = Factory.create(:user, :has_propose_priv => true).id
				render('/home/index')
				response.should have_tag('a[href=?]', '/dojo_sessions/new', 'Propose a new session')
			end

			it 'should not show the link to propose, if there are sessions' do 
				assigns[:dojo_sessions] = [Factory.create(:dojo_session)]
				session[:user_id] = Factory.create(:user, :has_propose_priv => true).id
				render('/home/index')
				response.should_not have_tag('a[href=?]', '/dojo_sessions/new', 'Propor uma nova sessão')
			end

			it 'should not show the link to propose, if im not logged in' do 
				assigns[:dojo_sessions] = []
				render('/home/index')
				response.should_not have_tag('a[href=?]', '/dojo_sessions/new', 'Propor uma nova sessão')
			end

			it 'should not show the link to propose, if i have no privileges' do 
				assigns[:dojo_sessions] = []
				session[:user_id] = Factory.create(:user, :has_propose_priv => false).id
				render('/home/index')
				response.should_not have_tag('a[href=?]', '/dojo_sessions/new', 'Propor uma nova sessão')
			end
			
		end

		context 'details' do
	
			before :each do 
				@dojo_session = Factory.create(:dojo_session, :confirmed_users=>[Factory.create(:user)])
				assigns[:dojo_sessions] = [@dojo_session]
				render('/home/index')
			end
	
			it 'should show the next proposed session date and title' do
				response.should include_text( @dojo_session.title)
				response.should include_text(I18n.l(@dojo_session.date, :format=>"pretty"))
				
			end
			
			it 'should present date in brazilian format' do
				the_date = I18n.l @dojo_session[:date], :format=>"pretty"
				response.should include_text(the_date)
			end
				
			it 'should not show the no-sessions message' do
				response.should_not have_tag('p', 'Nenhuma sessão proposta no momento.')
			end
					
		end
	
		it 'should show the three proposed sessions' do
			assigns[:dojo_sessions] = [Factory.create(:dojo_session), Factory.create(:dojo_session), Factory.create(:dojo_session)]
			render('home/index')
			dojo_sessions = assigns[:dojo_sessions]
			response.should have_tag('div[id=?]', "next_sessions", :text=>/.*#{dojo_sessions[0].title}*/)
			response.should have_tag('div[id=?]', "next_sessions", :text=>/.*#{dojo_sessions[1].title}*/)
			response.should have_tag('div[id=?]', "next_sessions", :text=>/.*#{dojo_sessions[2].title}*/)
		end
	
		it 'should show a link to the sessions list' do
			assigns[:dojo_sessions] = [Factory.create(:dojo_session)]
			render('home/index')
			response.should have_tag('div[id=?]', "next_sessions") do |div|
				div.should have_tag('a[href=?]', dojo_sessions_path, :text=>'more details >>')
			end
		end
		
	end
	
	it 'should have a link to the sessions history' do
		render('home/index')
		response.should have_tag('a[href=?]', "/history", 'Sessions history')
	end
	
end