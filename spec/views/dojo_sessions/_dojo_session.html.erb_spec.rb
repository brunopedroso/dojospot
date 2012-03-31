# encoding: UTF-8
require 'spec_helper'

def render_partial
	render(:partial => 'dojo_sessions/dojo_session', :locals=>{:dojo_session=>@dojo_session})
end

describe 'dojo_sessions/_dojo_session.html.erb' do
  
	before :each do 
	  @user = Factory.create(:user)
	  
	  controller.singleton_class.class_eval do
      protected
        def logged_in?
          not User.first.nil?
        end
        def current_user
          User.first
        end
        helper_method :logged_in?
        helper_method :current_user
    end
	end
		
	context 'details' do
	  
	  before :each do 
  	  @dojo_session = Factory.create(:dojo_session, :confirmed_users=>[@user])
  	  assign :locals, {:dojo_session=>@dojo_session}
  	end

		it 'should show the next proposed session' do
			render_partial
			rendered.should have_selector('h1', :content=>@dojo_session.title)
			rendered.should have_selector('p', :content=>@dojo_session.text)
			rendered.should contain(@dojo_session.place)
			rendered.should contain(I18n.l(@dojo_session.date, :format=>:pretty))
			rendered.should contain(@dojo_session.time)

		end
		
		it 'should present date in brazilian format' do
			render_partial
			the_date = I18n.l @dojo_session[:date], :format=>:pretty
			rendered.should contain(the_date)
		end
		
		it 'should not show the no-sessions message' do
			render_partial
			render_partial.should_not have_selector('p', :content=>'Nenhuma sessão proposta no momento.')
		end
				
		it 'should textilize the dojo session content' do
			@dojo_session.text = 'h3. meu titulo muito feliz'
			render_partial
			rendered.should have_selector('h3', :content=>'meu titulo muito feliz')
		end
				
		it 'should not show a link to edit if i am NOT logged in' do
			session[:user_id] = nil
			render_partial
			rendered.should_not have_selector('a', :href=>"/dojo_sessions/#{@dojo_session.id}/edit", :content=>'editar')
		end
		
		it 'should show a link to edit when i am logged in one of the confirmed users ' do
			# tem que ter privilégio
			@user.has_propose_priv=true
			@user.save
			
			render_partial
			rendered.should have_selector('a', :href=>"/dojo_sessions/#{@dojo_session.id}/edit", :content=>'Edit')
		end
		
		it 'should not show a link to edit if i am NOT a confirmed user' do
			session[:user_id] = Factory.create(:user).id
			render_partial
			rendered.should_not have_selector('a', :href=> "/dojo_sessions/#{@dojo_session.id}/edit", :conten=>'edit')
		end
		
		it 'should not show a link to edit if i do NOT have privileges' do
			@user.has_propose_priv=true
			@user.save
			render_partial
			rendered.should_not have_selector('a', :href => "/dojo_sessions/#{@dojo_session.id}/edit", :content=>'editar')
		end

	end
		
	
	context 'confirmation' do
		
		context 'link to confirm' do
			it 'should show a link to confirm presence in the session if there is nobody confirmed' do
				@dojo_session = Factory.create(:dojo_session)
				render_partial
				rendered.should have_selector('a', :href => "/dojo_sessions/#{@dojo_session.id}/confirm_presence", :content=>'Confirm my presence!')
			end
			
			it 'should show a link to confirm presence in the session if i am not one of the confirmed users' do
				@dojo_session = Factory.create(:dojo_session, :confirmed_users=>[Factory.create(:user)])
				render_partial
				rendered.should have_selector('a', :href => "/dojo_sessions/#{@dojo_session.id}/confirm_presence", :content=>'Confirm my presence!')
			end
	
			it 'should not show a link to confirm presence if i am already a confirmed user' do
				@dojo_session = Factory.create(:dojo_session, :confirmed_users=>[@user])
				render_partial
				rendered.should_not have_selector('a', :content=>'Confirmar minha presença')
			end
			
			it 'should show a link to confirm presence even if i am not logged in' do
				
				# a idéia é que caia na página de login, mas isso deve ser testado no controller, não aqui.
				
				session[:user_id] = nil
				@dojo_session = Factory.create(:dojo_session)
				render_partial
				rendered.should have_selector('a', :content=>'Confirm my presence!')
			end
			
		end
		
		
		context 'confirmed users list' do 
			
			it 'should show nowbody-confirmed-message if there is nobody confirmed' do
				@dojo_session = Factory.create(:dojo_session, :confirmed_users=>[])
				render_partial
				rendered.should_not have_selector('div', :id=>"dojo_session_#{@dojo_session.id}", :content=>'Confirmados até agora.')
				rendered.should have_selector('div', :id=> "dojo_session_#{@dojo_session.id}", :content=>'Nobody confirmed yet.')
			end
	
			it 'should not show nobody-confirmed-message if there is someone confirmed' do
				@dojo_session = Factory.create(:dojo_session, :confirmed_users=>[Factory.create(:user)])
				render_partial
				rendered.should have_selector("div#dojo_session_#{@dojo_session.id}", :content=>'Confirmed so far')
				rendered.should_not have_selector('div', :id=> "dojo_session_#{@dojo_session.id}", :content=>'Ninguém confirmou ainda.')
			end
	
			it 'should show the usernames of the confirmed users' do
				user1 = Factory.create(:user)
				user2 = Factory.create(:user)
				@dojo_session = Factory.create(:dojo_session, :confirmed_users=>[user1, user2])
				render_partial
				rendered.should have_selector("div#dojo_session_#{@dojo_session.id}", :content=>'Confirmed so far')
				rendered.should have_selector("div#dojo_session_#{@dojo_session.id}") do |div|
				  rendered.should have_selector("ol li", :content=>"#{user1.username}")
			  end
				rendered.should have_selector("div#dojo_session_#{@dojo_session.id}") do |div|
				  rendered.should have_selector("ol li", :content=>"#{user2.username}")
			  end

			end
	
			it 'should show the names of the confirmed users if they have filled a name' do
				user1 = Factory.create(:user, :name=>'my real name')
				user2 = Factory.create(:user)
				user3 = Factory.create(:user, :name=> '') #empty - this is a special case
				@dojo_session = Factory.create(:dojo_session, :confirmed_users=>[user1, user2, user3])
				render_partial
				
				rendered.should have_selector("div#dojo_session_#{@dojo_session.id}", :content=>'Confirmed so far')
				
				rendered.should have_selector("div#dojo_session_#{@dojo_session.id}") do |div|
				  rendered.should have_selector("ol li", :content=>"#{user1.name}")
				  rendered.should have_selector("ol li", :content=>"#{user2.username}")
				  rendered.should have_selector("ol li", :content=>"#{user3.username}")
			  end				
			end
			
			it 'should show the gravatar picture of the confirmed users' do
				user1 = Factory.create(:user)
				user2 = Factory.create(:user)
				@dojo_session = Factory.create(:dojo_session, :confirmed_users=>[user1, user2])
				render_partial
				
				#TODO didnt like this here.. =/
				hash1 = Digest::MD5.hexdigest(user1.email.downcase)
				hash2 = Digest::MD5.hexdigest(user2.email.downcase)
				
				rendered.should have_selector('img', :src=>"http://www.gravatar.com/avatar/#{hash1}.png?s=30")
				rendered.should have_selector('img', :src=>"http://www.gravatar.com/avatar/#{hash2}.png?s=30")
			end
			
			it 'should show a link to unconfirm, if the current_user is already confirmed' do
				@dojo_session = Factory.create(:dojo_session, :confirmed_users=>[@user])
				render_partial
				rendered.should have_selector("div#dojo_session_#{@dojo_session.id} a", :href=>unconfirm_presence_dojo_session_path(@dojo_session.id), :content=>'unconfirm')
			 end
	
			it 'should not show a link to unconfirm, if i am not confirmed' do
				user1 = Factory.create(:user)
				@dojo_session = Factory.create(:dojo_session, :confirmed_users=>[user1])
				
				render_partial
				rendered.should_not have_selector("div#dojo_session_#{@dojo_session.id} a", :href=>unconfirm_presence_dojo_session_path(@dojo_session.id), :content=>'unconfirm')
			 end
	
			it 'should not show a link to unconfirm, if i am not logged in' do
				@dojo_session = Factory.create(:dojo_session, :confirmed_users=>[@user])
				
				#session[:user_id] = nil
				# it ends up making the before each understand there is nobody logged in.. But it is not right =/
				User.delete_all
				
				render_partial
				rendered.should_not have_selector("div#dojo_session_#{@dojo_session.id} a", :href=>unconfirm_presence_dojo_session_path(@dojo_session.id), :content=>'unconfirm')
			 end
			
		end

		context 'a past session' do
			
			it 'should not show the confirmations div' do
				
				yesterday = Date.today-1
				@dojo_session = Factory.create(:dojo_session, :confirmed_users=>[@user], :date=>yesterday)
				
				render_partial
				rendered.should_not have_selector('div#confirmations')
				
			end
			
		end
		
	end

end