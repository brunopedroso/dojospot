require 'spec_helper'

describe DojoSessionsController do
	
	before :each do
		@user = Factory.create :user
		session[:user_id] = @user.id
	end
		
	context 'get new' do

		it 'should create a new dojo_session' do 
			dojo_session = mock_model(DojoSession,{
				:new_record? => true
			})
			DojoSession.should_receive(:new).and_return(dojo_session)
			get :new
			assigns[:dojo_session].should == dojo_session
		end

		it 'should redirect to login when not logged in' do
		 	session[:user_id] = nil
			get :new
			response.should redirect_to('/login')
		end
		
	end
	
	
	context 'post to dojo_sessions/create' do
		
		it 'should redirect to home page' do
			post :create, Factory.attributes_for(:dojo_session)
			response.should redirect_to('/')
		end
		
		it 'should save the new dojo_session' do 
			
			new_session = mock_model(DojoSession)
			new_session.should_receive(:save)
			
			args = Factory.attributes_for(:dojo_session).stringify_keys
			
			DojoSession.should_receive(:new).with(args).and_return(new_session)
			
			post :create, :dojo_session=>args
			
		end
		
		it 'should not create and redirect to login when not logged in' do
		 	session[:user_id] = nil
			args = Factory.attributes_for(:dojo_session).stringify_keys
			
			DojoSession.should_not_receive(:new)
			
			post :create, :dojo_session=>args
			response.should redirect_to('/login')
		end
		
	end
	
	context 'get to confirm presence' do
		
		it 'should redirect to home page' do
			dojo_session = Factory.create :dojo_session
			get :confirm_presence, :id=>dojo_session.id
			response.should redirect_to('/')
		end
		
		it 'should associate the current user with the dojo_session, as a confirmed user' do
			dojo_session = mock_model(DojoSession)

			id = 123
			dojo_session.stub!(:id).and_return(id)
			DojoSession.should_receive(:find).with(id).and_return(dojo_session)
			
			users=[]
			dojo_session.should_receive(:confirmed_users).and_return(users)
			dojo_session.should_receive(:save)
			
			get :confirm_presence, :id=>dojo_session.id
			#users[0].should == @user # deve ter adicionado o usuário atual na lista
		end
		
	end
	
	
	
end