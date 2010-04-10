require File.dirname(__FILE__) + '/../spec_helper'
 
describe SessionsController do

  integrate_views


	context 'new action' do

	  it "should render new template" do
	    get :new
	    response.should render_template(:new)
	  end

	end

	context 'create action' do
		
	  it "should render new template when authentication is invalid" do
	    User.stub_chain(:authenticate).and_return(nil)
	    post :create
	    response.should render_template(:new)
	    session['user_id'].should be_nil
	  end

	  it "should redirect when authentication is valid" do
			Factory.create :user
	    User.stub_chain(:authenticate).and_return(User.first)
	    post :create
	    response.should redirect_to(root_url)
	    session['user_id'].should == User.first.id
	  end
	
	end
  
end
