require 'spec_helper'

describe 'pages/show.html.erb' do
	
	it 'should include the page content' do
		
		assign :page, 'my content'
		
		render
		
		rendered.should contain('my content')
		
	end
	
end
