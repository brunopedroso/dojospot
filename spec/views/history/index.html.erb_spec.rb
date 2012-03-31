require 'spec_helper'

describe 'history/index.html.erb' do
	
	it 'should show title, date, time, place of each listed session' do
		
		dojo_sessions = [Factory.create(:dojo_session), 
														 Factory.create(:dojo_session), 
														 Factory.create(:dojo_session)]

		assign :dojo_sessions, dojo_sessions
		
		render
		
		dojo_sessions.each do |session|
			rendered.should have_selector('h2', :content => session.title)
			date = I18n.l(session.date, :format=>:pretty)
			date_time_place = "#{date}, #{session.time}, #{session.place}"
			rendered.should have_selector('span', :content => date_time_place)
		end
		
	end

	it 'should show a link to the details page on the title' do
		session = Factory.create(:dojo_session)
		assign :dojo_sessions, [session]
		render
		rendered.should have_selector('a', :href => "/dojo_sessions/#{session.id}", :content => session.title)
	end

	
end
