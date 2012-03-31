require 'spec_helper'

describe 'dojo_sessions/edit.html.erb' do
	
	it 'should render the form to PUT to /dojo_sessions/<id>' do
		
		dojo_session = Factory.create(:dojo_session)
		assign :dojo_session, dojo_session
		
		render
		
		rendered.should have_selector('form', :action=>"/dojo_sessions/#{dojo_session.id}") do |f|
			f.should have_selector('input', :type=>'hidden', :name=>'_method', :value=>'put')
		end
		
	end	
	
end