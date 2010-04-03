require 'spec_helper'

describe DojoSession do

	describe 'find_proposed_sessions' do
		
		it 'should show a future session' do 
			
			Factory.create :dojo_session

			proposed_sessions = DojoSession.find_proposed_sessions
			proposed_sessions.length.should == 1 
			
		end
		
		it 'should not find a past session' do
			
			Factory.create :dojo_session, :date=>Date.today - 1

			proposed_sessions = DojoSession.find_proposed_sessions
			proposed_sessions.length.should == 0

		end
		
	end
	

end