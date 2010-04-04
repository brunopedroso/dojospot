require 'spec_helper'

describe 'home page' do
	
	context 'without proposed sessions' do
		before :each do 
			assigns[:dojo_sessions] = []
		end
		
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
			response.should have_tag('p', @dojo_session.place)
			response.should have_tag('p', @dojo_session.date.to_s_br)
			response.should have_tag('p', @dojo_session.time)

		end
		
		it 'should present date in brazilian format' do
			render('home/index')
			the_date = @dojo_session[:date].to_s_br
			response.should have_tag('p', the_date)
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
	
	
end