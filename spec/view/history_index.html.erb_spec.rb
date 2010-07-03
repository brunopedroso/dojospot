require 'spec_helper'

describe 'dojo session history index' do
	
	it 'should show title and date of each listed session' do
		
		assigns[:dojo_sessions] = [Factory.create(:dojo_session), 
															 Factory.create(:dojo_session), 
															 Factory.create(:dojo_session)]
		
		render 'history/index'
		
		assigns[:dojo_sessions].each do |session|
			response.should have_tag('h2', session.title)
			response.should have_tag('span', I18n.l(session.date, :format=>"default"))
		end
		
		
	end
	
end
