require 'spec_helper'

describe 'edit profile page' do
	
	it 'should have an input field for name' do
		
		render 'users/edit'
		response.should have_tag('input[type=?][name=?][value=?]', 
															'text', 'name', '')
		
	end
	
end
