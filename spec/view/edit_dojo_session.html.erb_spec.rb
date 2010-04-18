require 'spec_helper'

describe 'edit session page' do
	
	it 'should render the form to PUT to /dojo_sessions/<id>' do
		
		dojo_session = Factory.build(:dojo_session)
		assigns[:dojo_session] = dojo_session
		
		render('/dojo_sessions/edit.html')
		
		puts response.body
		
		response.should have_tag('form[action=?][method=?]','/dojo_sessions', 'put')
		
	end
	
	
end