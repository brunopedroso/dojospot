require 'spec_helper'

describe 'new session page' do

	before :each do
		assigns[:dojo_session] = stub_model(DojoSession,
      :new_record? => true
    )
	end

	it 'should have a form that posts to dojo_sessions' do
		render('dojo_sessions/new.html')
		response.should have_tag('form[action=?][method=?]','/dojo_sessions', 'post')
	end

	it 'should have fields for title, text, place, date and time' do
		render('dojo_sessions/new.html')
		
		response.should have_tag('form label', 'Título')
		response.should have_tag('form input[type=?][name=?]', 'text', 'dojo_session[title]')
		
		response.should have_tag('form label', 'Texto')
		response.should have_tag('form textarea[name=?]', 'dojo_session[text]')
		
		response.should have_tag('form label', 'Local')
		response.should have_tag('form input[type=?][name=?]', 'text', 'dojo_session[place]')
		
		response.should have_tag('form label', 'Data')
		response.should have_tag('form input[type=?][name=?]', 'text', 'dojo_session[date]')
		
		response.should have_tag('form label', 'Horário')
		response.should have_tag('form input[type=?][name=?]', 'text', 'dojo_session[time]')
		
	end
	
	it 'should have a submit for proposing a dojo session' do 
		render('dojo_sessions/new.html')
		response.should have_tag('form input[type=?][value=?]', 'submit', 'Salvar')
	end
	
	
end