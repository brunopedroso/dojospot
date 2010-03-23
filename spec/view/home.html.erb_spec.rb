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
																						 :date=>"23/03/2010",
																						 :time=>"from 17:00 to 19:00"})

			assigns[:dojo_sessions] = [@dojo_session]
		end
		
		it 'should show the next proposed session' do
			render('home/index')

			response.should have_tag('h1', @dojo_session.title)
			response.should have_tag('p', @dojo_session.text)
			response.should have_tag('p', @dojo_session.place)
			response.should have_tag('p', @dojo_session.date)
			response.should have_tag('p', @dojo_session.time)

		end
		
		it 'should not show the no-sessions message' do
			render('home/index')
			response.should_not have_tag('p', 'Nenhuma sessão proposta no momento.')
		end

	end
	
	
	
end