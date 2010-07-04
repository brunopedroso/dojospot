require 'spec_helper'

describe 'dojo session history index' do
	
	it 'should show title, date, time, place of each listed session' do
		
		assigns[:dojo_sessions] = [Factory.create(:dojo_session), 
															 Factory.create(:dojo_session), 
															 Factory.create(:dojo_session)]
		
		render 'history/index'
		
		assigns[:dojo_sessions].each do |session|
			response.should have_tag('h2', session.title)
			date = I18n.l(session.date, :format=>"pretty")
			date_time_place = ".*#{date}, #{session.time}, #{session.place}.*"
			response.should have_tag('span', Regexp.new(date_time_place))
		end
		
		
	end
	
end
