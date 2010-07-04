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

	it 'should show a link to the details page on the title' do
		session = Factory.create(:dojo_session)
		assigns[:dojo_sessions] = [session]
		render 'history/index'
		response.should have_tag('a[href=?]', "/dojo_sessions/#{session.id}", session.title)
	end

	
end
