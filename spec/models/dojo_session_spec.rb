require 'spec_helper'

describe DojoSession do

	should_have_and_belong_to_many :confirmed_users, :class_name=>"User", :uniq=>true

	describe 'find_proposed_sessions' do
		
		it 'should show a future session' do 
			
			Factory.create :dojo_session

			proposed_sessions = DojoSession.find_proposed_sessions
			proposed_sessions.length.should == 1 
			
		end

		it  'should show a session proposed for today' do
			
			Factory.create :dojo_session, :date=>Date.today

			proposed_sessions = DojoSession.find_proposed_sessions
			proposed_sessions.length.should == 1 
			
		end
		
		it 'should show the sessions ordered by date' do
			
			today_session1 = Factory.create :dojo_session, :date=>Date.today
			today_session2 = Factory.create :dojo_session, :date=>Date.today
			tomorow_session =Factory.create :dojo_session, :date=>(Date.today+1)
			two_days_sesion = Factory.create :dojo_session, :date=>(Date.today+2)
			
			proposed_sessions = DojoSession.find_proposed_sessions
			
			proposed_sessions[0].should == today_session2
			proposed_sessions[1].should == today_session1
			proposed_sessions[2].should == tomorow_session
			proposed_sessions[3].should == two_days_sesion
			
		end
		
		it 'should not show a past session' do
			
			Factory.create :dojo_session, :date=>Date.today - 1

			proposed_sessions = DojoSession.find_proposed_sessions
			proposed_sessions.length.should == 0

		end
		
	end
	
	describe 'new session' do

			# TODO how can I test this only for brazilian locale?
			# it 'should parse date in brazilian format' do 
			# 	attrs = Factory.attributes_for(:dojo_session, :date=>"11/04/2010")
			# 	s = DojoSession.new(attrs)
			# 	'13/04/2010'.to_date.month.should == 4
			# 	s.date.month.should == 4
			# end
		
	end
	

end