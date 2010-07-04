require File.dirname(__FILE__) + '/../spec_helper'
require 'mocha'
 
describe HistoryController do
	
	context 'index' do
		
		it 'should list the past sessions' do
			myArray = ['an','array']
			
			#someDay: separate the query in a class method of dojo session
			DojoSession.should_receive(:find).with(:all, ["date < ?", Date.today], :order=>"date desc").and_return(myArray)
			
			get :index
			
			assigns[:dojo_sessions].should == myArray
			
		end
	end

	
end
