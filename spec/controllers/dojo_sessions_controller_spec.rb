require 'spec_helper'

describe DojoSessionsController do
	
	context 'get new' do
		
		it 'should create a new dojo_session' do 
			dojo_session = mock_model(DojoSession,{
				:new_record? => true
			})
			DojoSession.should_receive(:new).and_return(dojo_session)
			get :new
			assigns[:dojo_session].should == dojo_session
		end
		
		
	end
	
	
	context 'post to dojo_sessions/create' do
		
		it 'should redirect to home page' do
			
			post :create, {:title=>"um título",
										 :text=>"um texto",
										 :place=>"um local",
										 :date=>"03/04/2010",
										 :time=>"das 17:00 às 19:00"}
			
			response.should redirect_to('/')
			
		end
		
		it 'should save the new dojo_session' do 
			
			new_session = mock_model(DojoSession)
			new_session.should_receive(:save)
			
			args = {"title"=>"um título",
						  "text"=>"um texto",
						  "place"=>"um local",
						  "date"=>"03/04/2010",
						  "time"=>"das 17:00 às 19:00"}
			
			DojoSession.should_receive(:new).with(args).and_return(new_session)
			
			post :create, :dojo_session=>args
			
		end
		
	end
	
	
	
end