require File.dirname(__FILE__) + '/../spec_helper'
require 'mocha'
 
describe UsersController do
  fixtures :all
  integrate_views
  
	describe "new action" do
	  it "should render new template" do
	    get :new
	    response.should render_template(:new)
	  end
	end

 	describe "create action" do
	  it "create action should render new template when model is invalid" do
	    User.any_instance.stubs(:valid?).returns(false)
	    post :create
	    response.should render_template(:new)
	  end
  
	  it "create action should redirect when model is valid" do
	    User.any_instance.stubs(:valid?).returns(true)
	    post :create
	    response.should redirect_to(root_url)
	    session['user_id'].should == assigns['user'].id
	  end
	end
	
	describe "edit action" do
		it "should display the current user data" do
			user = Factory.build(:user, :id=>1)
			session[:user_id]=user.id
			User.stub!(:find).with(user.id).and_return(user)
			get :edit
			assigns[:user].should == user
		end
	end

	describe "update action" do
		
		before :each do
			@attrs = Factory.attributes_for(:user, :id=>1)
			@user = User.new(@attrs)
			User.stub!(:find).and_return(@user)
		end
		
		it "should render the edit template again" do
			put :update, :user=>@attrs, :id=>@attrs[:id]
			response.should redirect_to(edit_profile_path)
		end
		
		it "should show a success message" do
			put :update, :user=>@attrs, :id=>@attrs[:id]
			flash[:notice].should == "Your profile has been successfully updated!"
		end
		
		it 'should update the user' do
			# user = mock_model(User)
			User.should_receive(:find).with(@attrs[:id].to_s).and_return(@user)
			@user.should_receive(:update_attributes).with(@attrs.stringify_keys)
			@user.should_receive(:save)
			put :update, :user=>@attrs, :id=>@attrs[:id]
		end
		
		describe "with invalid user" do
			
			before :each do
				@user.stub!(:valid?).and_return(false)
			end
			
			it "should render the edit templage again" do
				put :update, :user=>@attrs, :id=>@attrs[:id]
				response.should render_template(:edit)
			end

			it "should have no flash notice" do
				put :update, :user=>@attrs, :id=>@attrs[:id]
				flash[:notice].should be_nil
			end

		end

		
	end

	describe "index action" do

	  it "should render index template" do
	    get :index
	    response.should render_template(:index)
	  end

	  it "should find all users" do
			my_array = [Factory.create(:user),Factory.create(:user)]
			User.should_receive(:find).with(:all).and_return(my_array)
	    get :index
			assigns[:users].should == my_array
	  end

	end
	
end

