require 'spec_helper'

describe 'page show content' do
	
	it 'should include the page content' do
		
		assigns[:page] = 'my content'
		
		render 'pages/show'
		
		response.should include_text('my content')
		
	end
	
end
