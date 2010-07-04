require 'spec_helper'

describe DojoSessionsController do
	
	before :each do
		@user = Factory.create :user
		session[:user_id] = @user.id
	end
	
	context 'index' do
		
		it 'should assign the proposed dojo_sessions' do
			
			myArray = ['my_array']
			DojoSession.should_receive(:find_proposed_sessions).and_return(myArray)
			
			get :index
			
			assigns[:dojo_sessions].should == myArray
			
		end
		
		it 'should access index even if not logged in' do 
			session[:user_id]=nil
			get :index
			response.should be_success
			response.should render_template('dojo_sessions/index.html.erb')
		end
		
	end
	
	context 'get new' do

		before :each do
			@user = Factory.create(:user, :has_propose_priv=>true)
			session[:user_id] = @user.id
		end


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

		it 'should redirect to login if the user does not have propose privilege' do
		 	@user = Factory.create(:user, :has_propose_priv=>false)
			session[:user_id] = @user.id
			get :new
			response.should redirect_to('/login')
		end
		
	end
	
	
	context 'post to dojo_sessions/create' do
		
		before :each do
			@user = Factory.create(:user, :has_propose_priv=>true)
			session[:user_id] = @user.id
		end
	
		
		it 'should redirect to index' do
			post :create, Factory.attributes_for(:dojo_session)
			response.should redirect_to(dojo_sessions_path)
		end
		
		it 'should save the new dojo_session' do 
			
			new_session = mock_model(DojoSession)
			new_session.should_receive(:save)
			new_session.stub!(:confirmed_users).and_return([])
			
			args = Factory.attributes_for(:dojo_session).stringify_keys
			
			DojoSession.should_receive(:new).with(args).and_return(new_session)
			
			post :create, :dojo_session=>args
			
		end

		it 'should associate current_user as confirmed' do 
			
			new_session = mock_model(DojoSession)
			confirmed_users = mock(Array)
			new_session.should_receive(:save)
			
			args = Factory.attributes_for(:dojo_session).stringify_keys
			
			DojoSession.should_receive(:new).with(args).and_return(new_session)
			new_session.should_receive(:confirmed_users).and_return(confirmed_users)
			confirmed_users.should_receive(:<<).with(@user)
			
			post :create, :dojo_session=>args
			
		end

		
		context 'when not logged in' do

			it 'should not create the session' do
			 	session[:user_id] = nil
				args = Factory.attributes_for(:dojo_session).stringify_keys
				DojoSession.should_not_receive(:new)
				post :create, :dojo_session=>args
			end

			it 'should redirect to login' do
			 	session[:user_id] = nil
				args = Factory.attributes_for(:dojo_session).stringify_keys
				post :create, :dojo_session=>args
				response.should redirect_to('/login')
			end

		end
		
		it 'should redirect to login if the user does not have propose privilege' do
		 	@user = Factory.create(:user, :has_propose_priv=>false)
			session[:user_id] = @user.id
			args = Factory.attributes_for(:dojo_session).stringify_keys
			post :create, :dojo_session=>args
			response.should redirect_to('/login')
		end
		

		
	end
	
	context 'get the edit page' do

		before :each do
			@user.has_propose_priv=true
			@user.save
		end
		
		it 'should render the edit page' do
			
			dojo_session = mock_model(DojoSession)
			
			DojoSession.stub!(:find).and_return(dojo_session)
			
			get :edit
			response.should render_template('edit')
		end
		
		it 'should assign the session' do
			
			id = 33
			
			dojo_session = mock_model(DojoSession)
			
			DojoSession.should_receive(:find).with(id).and_return(dojo_session)
			
			get :edit, :id=>id
			assigns[:dojo_session].should == dojo_session
		end
		
		it 'should redirect to login if the user does not have privileges' do
			
			@user.has_propose_priv=false
			@user.save
						
			get :edit
			response.should redirect_to(login_path)
			
		end
		
	end
	
	context 'put to edit the session' do
		
		before :each do
			@user.has_propose_priv=true
			@user.save
		end
		
		
		it 'should update the sessions atributes' do
			attrs = Factory.attributes_for(:dojo_session)
			id = 33
			
			dojo_session = mock_model(DojoSession)
			DojoSession.should_receive(:find).with(id).and_return(dojo_session)
			dojo_session.should_receive(:update_attributes).with(attrs.stringify_keys)
			dojo_session.should_receive(:save)
			
			post :update, :id=>id, :dojo_session=>attrs.stringify_keys
		end
		
		it 'should redirect to the sessions index page' do 
			
			attrs = Factory.attributes_for(:dojo_session)
			id = 33
			
			dojo_session = mock_model(DojoSession)
			DojoSession.stub!(:find).and_return(dojo_session)
			dojo_session.stub!(:update_attributes)
			dojo_session.stub!(:save)
			
			post :update, :id=>id, :dojo_session=>attrs.stringify_keys
			
			response.should redirect_to(dojo_sessions_path)
			
		end
		
		it 'should redirect to login if the user does not have privileges' do
			
			@user.has_propose_priv=false
			@user.save
			
			id = 33
			attrs = Factory.attributes_for(:dojo_session)
			post :update, :id=>id, :dojo_session=>attrs.stringify_keys
			
			response.should redirect_to(login_path)
			
		end

		
		# TODO 'should it validate any field?'
		
	end
	
	
	context 'get to confirm presence' do
		
		it 'should redirect to index' do
			dojo_session = Factory.create :dojo_session
			get :confirm_presence, :id=>dojo_session.id
			response.should redirect_to(dojo_sessions_path)
		end
		
		it 'should associate the current user with the dojo_session, as a confirmed user' do
			dojo_session = mock_model(DojoSession)

			id = 123
			dojo_session.stub!(:id).and_return(id)
			DojoSession.should_receive(:find).with(id).and_return(dojo_session)
			
			users=[]
			dojo_session.stub!(:confirmed_users).and_return(users)
			dojo_session.should_receive(:save)
			
			get :confirm_presence, :id=>dojo_session.id
			users[0].should == @user # deve ter adicionado o usuário atual na lista
		end
		
		it 'should not re-associate the user if he is already confirmed' do
			
			# coloquei um uniq no model - faz ele ignorar as linhas duplicadas
			#   mas esse teste garante que não se criam mais linhas a toa na tabela de relacionamento
			
			dojo_session = mock_model(DojoSession)
		
			id = 123
			users=[@user]
			
			dojo_session.stub!(:id).and_return(id)
			dojo_session.stub!(:confirmed_users).and_return(users)
			DojoSession.should_receive(:find).with(id).and_return(dojo_session)
			
			dojo_session.stub!(:confirmed_users).and_return(users)
			
			get :confirm_presence, :id=>dojo_session.id
		
			users.length.should == 1
			users[0].should == @user # deve ter mantido só o usuário atual na lista
		end
		
	end
	
	context 'get to unconfirm presence' do
		
		it 'should redirect to index' do
			dojo_session = Factory.create :dojo_session
			get :unconfirm_presence, :id=>dojo_session.id
			response.should redirect_to(dojo_sessions_path)
		end
		
		it 'should remove the current user from the confirmed users' do
			
			dojo_session = mock_model(DojoSession)

			id = 123
			dojo_session.stub!(:id).and_return(id)
			DojoSession.should_receive(:find).with(id).and_return(dojo_session)
			
			users = mock(Array)
			users.should_receive(:delete).with(@user)
			
			dojo_session.stub!(:confirmed_users).and_return(users)
			dojo_session.should_receive(:save)
			
			get :unconfirm_presence, :id=>dojo_session.id
			
		end
	
	end
	
	context 'get session details (show)' do
		
		it 'should render show template' do
			DojoSession.stub!(:find)
			get :show, :id=>1
			response.should render_template('show')
		end
		
		it 'should load the dojo_session' do 
			DojoSession.should_receive(:find).with("33").and_return("nothing")
			get :show, :id=>33
			assigns[:dojo_session].should == "nothing"
		end
		
		it 'should access index session details if not logged in' do
			DojoSession.stub!(:find)
			session[:user_id]=nil
			get :show, :id=>1
			response.should be_success
			response.should render_template('dojo_sessions/show.html.erb')
		end
		
	end
	
end