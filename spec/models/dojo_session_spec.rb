require 'spec_helper'

describe DojoSession do

	describe 'find_proposed_sessions' do
		
		it 'should show a future session' do 
			
			
			
			proposed_sessions = DojoSession.find_proposed_sessions
			proposed_sessions.length.should == 1 
			
		end
		
	end
	

end