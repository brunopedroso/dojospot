require 'spec_helper'

describe 'dojo_sessions/new.html.erb' do

	before :each do
	  @dojo_session = stub_model(DojoSession,
      :new_record? => true
    )
		assign :dojo_session, @dojo_session
	end

	it 'should have a form that posts to dojo_sessions' do
		render
		rendered.should have_selector('form', :action=>"/dojo_sessions/#{@dojo_session.id}", :method=>'post')
	end

	it 'should have fields for title, text, place, date and time' do
		render
		
		rendered.should have_selector('form label', :content=>'Title')
		rendered.should have_selector('form input', :type=>'text', :name=>'dojo_session[title]')
		
		rendered.should have_selector('form label', :content=>'Text')
		rendered.should have_selector('form textarea', :name=>'dojo_session[text]')
		
		rendered.should have_selector('form label', :content=>'Place')
		rendered.should have_selector('form input', :type=>'text', :name=>'dojo_session[place]')
		
		rendered.should have_selector('form label', :content=>'Date')
		rendered.should have_selector('form input', :type=>'text', :name=>'dojo_session[date]')
		
		rendered.should have_selector('form label', :content=>'Time')
		rendered.should have_selector('form input', :type=>'text', :name=>'dojo_session[time]')
		
	end
	
	it 'should have a submit for proposing a dojo session' do 
		render
		rendered.should have_selector('form input', :type=>'submit', :value=>'Save')
	end
	
	
end