require 'spec_helper'

describe 'edit session page' do
	
	it 'should render the form to PUT to /dojo_sessions/<id>' do
		
		dojo_session = Factory.create(:dojo_session)
		assigns[:dojo_session] = dojo_session
		
		render('/dojo_sessions/edit.html')
		
		response.should have_tag('form[action=?]',"/dojo_sessions/#{dojo_session.id}") do |f|
			f.should have_tag('input[type=?][name=?][value=?]', 'hidden', '_method', 'put')
		end
		
	end	
	
end