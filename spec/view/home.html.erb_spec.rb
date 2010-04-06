require 'spec_helper'

describe 'home page' do
	
	before :each do 
		assigns[:dojo_sessions] = []
	end
	
	context 'without proposed sessions' do
		
		it 'should show no-sessions message' do 
			render('home/index')
			response.should have_tag('p', 'Nenhuma sessão proposta no momento.')
		end
		
	end
	
	context 'with one proposed session' do
		
		before :each do 
			@dojo_session = stub_model(DojoSession, {:title=>"test title",
																						 :text=>"test text",
																						 :place=>"test place",
																						 :date=>Date.today,
																						 :time=>"from 17:00 to 19:00"})

			assigns[:dojo_sessions] = [@dojo_session]
		end
		
		it 'should show the next proposed session' do
			render('home/index')

			response.should have_tag('h3', @dojo_session.title)
			response.should have_tag('p', @dojo_session.text)
			response.should include_text(@dojo_session.place)
			response.should include_text(I18n.l(@dojo_session.date, :format=>"pretty"))
			response.should include_text(@dojo_session.time)

		end
		
		it 'should present date in brazilian format' do
			render('home/index')
			the_date = I18n.l @dojo_session[:date], :format=>"pretty"
			response.should include_text(the_date)
		end
		
		it 'should not show the no-sessions message' do
			render('home/index')
			response.should_not have_tag('p', 'Nenhuma sessão proposta no momento.')
		end

	end
	
	context 'with three proposed session' do
		
		before :each do 
			assigns[:dojo_sessions] = [Factory.build(:dojo_session), Factory.build(:dojo_session), Factory.build(:dojo_session)]
		end
		
		it 'should show the title of the three' do
			render('home/index')
			dojo_sessions = assigns[:dojo_sessions]
			response.should have_tag('h3', dojo_sessions[0].title)
			response.should have_tag('h3', dojo_sessions[1].title)
			response.should have_tag('h3', dojo_sessions[2].title)
		end

	end
	
	context 'not logged in' do
			
			it 'should show a login link' do
				render('home/index')
				response.should have_tag('a[href=?]', '/sessions/new', 'Log in')
			end
			
	end
	
	
end