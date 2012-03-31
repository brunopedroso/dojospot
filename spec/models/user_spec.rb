require File.dirname(__FILE__) + '/../spec_helper'

describe User do
  def new_user(attributes = {})
    attributes[:username] ||= 'foo'
    # attributes[:email] ||= 'foo@example.com'
    attributes[:password] ||= 'abc123'
    attributes[:password_confirmation] ||= attributes[:password]
    User.new(attributes)
  end
  
  before(:each) do
    User.delete_all
  end
  
  it "should be valid" do
    new_user.should be_valid
  end
  
  it "should require username" do
    u = User.new
    u.username = ''
    u.should have(1).error_on(:username)
  end
  
  it "should require password" do
    new_user(:password => '').should have(1).error_on(:password)
  end
  
  it "should require well formed email" do
    new_user(:email => 'foo@bar@example.com').should have(1).error_on(:email)
  end

  it "should not require email" do
    new_user(:email => nil).should be_valid
		new_user(:email => "").should be_valid
  end
  
  it "should validate uniqueness of email" do
    new_user(:email => 'bar@example.com').save!
    new_user(:email => 'bar@example.com').should have(1).error_on(:email)
  end
  
  it "should validate uniqueness of username" do
    new_user(:username => 'uniquename').save!
    new_user(:username => 'uniquename').should have(1).error_on(:username)
  end
  
  it "should not allow odd characters in username" do
    new_user(:username => 'odd ^&(@)').should have(1).error_on(:username)
  end
  
  it "should validate password is longer than 3 characters" do
    new_user(:password => 'bad').should have(1).error_on(:password)
  end
  
  it "should require matching password confirmation" do
    new_user(:password_confirmation => 'nonmatching').should have(1).error_on(:password)
  end
  
  it "should generate password hash and salt on create" do
    user = new_user
    user.save!
    user.password_hash.should_not be_nil
    user.password_salt.should_not be_nil
  end
  
  it "should authenticate by username" do
    user = new_user(:username => 'foobar', :password => 'secret')
    user.save!
    User.authenticate('foobar', 'secret').should == user
  end
  
  it "should authenticate by email" do
    user = new_user(:email => 'foo@bar.com', :password => 'secret')
    user.save!
    User.authenticate('foo@bar.com', 'secret').should == user
  end
  
  it "should not authenticate bad username" do
    User.authenticate('nonexisting', 'secret').should be_nil
  end
  
  it "should not authenticate bad password" do
    new_user(:username => 'foobar', :password => 'secret').save!
    User.authenticate('foobar', 'badpassword').should be_nil
  end

	it 'should start without propose_privilege, by default' do
		user = new_user()
		user.has_propose_priv?.should == false
	end

	it 'should store the name in the database' do
		user = new_user
		user.name = "bruno"
		user.save!
		other = User.find user.id
		other.name.should == user.name
	end

	it 'should store the name in the database with mass assignment' do
		user = Factory.create(:user)
		name = "a strange name"
		user.update_attributes!({:name=>name})
		user.save
		other = User.find user.id
		other.name.should == name
	end

	it 'should store the page_url in the database' do
		user = new_user
		user.page_url = "http://myurl.com"
		user.save!
		other = User.find user.id
		other.page_url.should == user.page_url
	end

  it "should require well formed url" do
    new_user(:page_url => 'invalid url').should have(1).error_on(:page_url)
		new_user(:page_url => 'invalid_url').should have(1).error_on(:page_url)
		new_user(:page_url => 'function(){any_malicious_code()}').should have(1).error_on(:page_url)
		
		#need to fill protocol http or https
		new_user(:page_url => 'www.valid_url.com?any=thing').should have(1).error_on(:page_url)
		
		new_user(:page_url => 'http://valid_url.com?any=thing').should have(0).errors
		new_user(:page_url => 'https://user@valid_url.com:8080?any=thing').should have(0).errors
  end
	
	it 'should store the page_url in the database with mass assignment' do
		user = Factory.create(:user)
		page_url = "http://qwe.com"
		user.update_attributes!({:page_url=>page_url})
		user.save
		other = User.find user.id
		other.page_url.should == page_url
	end

end
