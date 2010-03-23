require 'spec_helper'

describe HomeController do
	
	context 'index' do
		
		it 'should assign the proposed dojo_sessions' do
			
			myArray = ['my_array']
			DojoSession.should_receive(:find_proposed_sessions).and_return(myArray)
			
			get :index
			
			assigns[:dojo_sessions].should == myArray
			
		end
		
	end
	
end